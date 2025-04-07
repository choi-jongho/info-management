<?php
    require_once('database.php');
    require_once('functions.php');

    session_start();
    $officer_id = $_SESSION['officer_id'] ?? null;

    // Ensure officer is logged in
    if (!$officer_id) {
        header("Location: login.php");
        exit();
    }

    $errors = [];
    $success = false;
    $receipt_data = [];

    // Handle form submission for adding payments
    if ($_SERVER["REQUEST_METHOD"] === "POST") {
        $member_id = sanitize_input($_POST['member_id'] ?? '');
        $amounts = $_POST['amount'] ?? []; // Array of amounts
        $semesters = $_POST['semester'] ?? []; // Array of semesters
        $school_years = $_POST['school_year'] ?? []; // Array of school years

        // Validate inputs
        if (empty($member_id)) {
            $errors[] = "Member ID is required.";
        }

        if (empty($amounts) || !is_array($amounts)) {
            $errors[] = "At least one payment amount is required.";
        }

        foreach ($amounts as $key => $amount) {
            if (!is_numeric($amount) || $amount <= 0) {
                $errors[] = "Payment amount must be a positive number.";
            }
        }

        // Check if member exists
        if (empty($errors)) {
            $stmt = $conn->prepare("SELECT member_id, CONCAT(first_name, ' ', last_name) AS member_name FROM members WHERE member_id = ?");
            $stmt->bind_param("s", $member_id);
            $stmt->execute();
            $result = $stmt->get_result();

            if ($result->num_rows === 0) {
                $errors[] = "Member ID does not exist.";
            } else {
                $member = $result->fetch_assoc();
                $member_name = $member['member_name'];
            }

            $stmt->close();
        }

        // Process payments
        if (empty($errors)) {
            $conn->begin_transaction(); // Start transaction
            $payment_ids = []; // Track payment IDs for receipt

            try {
                foreach ($amounts as $key => $amount) {
                    $semester = sanitize_input($semesters[$key]);
                    $school_year = sanitize_input($school_years[$key]);

                    // Check if the semester and school year match an existing fee record
                    $stmt = $conn->prepare("SELECT fee_amount FROM fees WHERE member_id = ? AND semester = ? AND school_year = ?");
                    $stmt->bind_param("sss", $member_id, $semester, $school_year);
                    $stmt->execute();
                    $fee_result = $stmt->get_result();

                    if ($fee_result->num_rows === 0) {
                        throw new Exception("Payment unsuccessful: No matching fee found for Semester $semester and SY $school_year.");
                    }

                    // Fetch the fee amount
                    $fee_row = $fee_result->fetch_assoc();
                    $fee_amount = $fee_row['fee_amount'];
                    $stmt->close();

                    // Proceed only if payment covers the fee
                    if ($amount >= $fee_amount) {
                        // Insert payment record
                        $stmt = $conn->prepare("INSERT INTO payments (member_id, amount, payment_date, semester, school_year) VALUES (?, ?, NOW(), ?, ?)");
                        $stmt->bind_param("sdss", $member_id, $amount, $semester, $school_year);

                        if ($stmt->execute()) {
                            $payment_id = $conn->insert_id;
                            $payment_ids[] = $payment_id;
                            
                            $stmt->close();

                            // Delete the fee record after successful payment
                            $stmt = $conn->prepare("DELETE FROM fees WHERE member_id = ? AND semester = ? AND school_year = ?");
                            $stmt->bind_param("sss", $member_id, $semester, $school_year);

                            if ($stmt->execute()) {
                                log_activity("Add Payment", "Payment of ₱$amount added for Member: $member_name (ID: $member_id), Semester: $semester, SY: $school_year", $officer_id);
                                log_activity("Delete Fee", "Deleted fee for Member: $member_name (ID: $member_id), Semester: $semester, SY: $school_year", $officer_id);
                                
                                // Add to receipt data
                                $receipt_data[] = [
                                    'payment_id' => $payment_id,
                                    'amount' => $amount,
                                    'semester' => $semester,
                                    'school_year' => $school_year
                                ];
                            } else {
                                throw new Exception("Failed to delete fee record.");
                            }
                        } else {
                            throw new Exception("Failed to record payment.");
                        }
                    } else {
                        throw new Exception("Payment unsuccessful: Amount is less than the fee amount.");
                    }
                }

                $conn->commit(); // Commit transaction if all actions succeed
                $success = true;
                
                // Store receipt data in session to display on receipt page
                $_SESSION['receipt_data'] = [
                    'member_id' => $member_id,
                    'member_name' => $member_name,
                    'payments' => $receipt_data,
                    'payment_date' => date('Y-m-d H:i:s'),
                    'officer_id' => $officer_id
                ];
                
                // Get officer name
                $stmt = $conn->prepare("SELECT CONCAT(m.first_name, ' ', m.last_name) AS officer_name 
                FROM officers o 
                JOIN members m ON o.member_id = m.member_id 
                WHERE o.officer_id = ?");
                $stmt->bind_param("s", $officer_id);
                $stmt->execute();
                $result = $stmt->get_result();
                $officer = $result->fetch_assoc();
                $_SESSION['receipt_data']['officer_name'] = $officer['officer_name'];
                $stmt->close();

                // Add this code to fetch the role name
                $stmt = $conn->prepare("
                    SELECT r.role_name 
                    FROM officers o
                    JOIN role r ON o.role_id = r.role_id
                    WHERE o.officer_id = ?
                ");
                $stmt->bind_param("s", $officer_id); // Use the officer_id variable here
                $stmt->execute();
                $role_result = $stmt->get_result();
                $role_row = $role_result->fetch_assoc();
                $role_name = $role_row['role_name'] ?? 'Officer'; // Default to 'Officer' if no role found
                $_SESSION['receipt_data']['officer_role'] = $role_name; // Add role name to receipt data
                $stmt->close();
                
                header("Location: payment_receipt.php");
                exit(); // Redirect to receipt page
            } catch (Exception $e) {
                $conn->rollback(); // Rollback on failure
                $errors[] = $e->getMessage();
            }
        }
    }
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Payment | INTEL</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="icon" href="images/info-tech.png">
</head>
<style>
    html, body {
        height: 100%;
        margin: 0;
        display: flex;
        flex-direction: column;
        background-color: #f8f9fa;
    }
    main {
        flex: 1;
    }
    .bg-navy {
        background-color: #001f3f !important;
    }
    .text-white {
        color: #ffffff !important;
    }
    .btn-navy {
        background-color: #001f3f;
        border-color: #001f3f;
        color: #fff;
    }
    .btn-navy:hover {
        background-color: #004080 !important;
        color: #fff;
    }
    .fee-list {
        max-height: 300px;
        overflow-y: auto;
    }
</style>
<body>
    <!-- Header -->
    <header class="bg-navy text-white py-3">
        <div class="container d-flex justify-content-between align-items-center">
            <h1><i class="fa-solid fa-coins me-2"></i>Add Payments</h1>
            <a href="members.php" class="btn btn-outline-light">
                <i class="fas fa-arrow-left me-2"></i>Back to Members
            </a>
        </div>
    </header>

    <main class="container my-5">
        <!-- Display success/error messages -->
        <?php if (!empty($errors)): ?>
            <div class="alert alert-danger alert-dismissible fade show">
                <strong><i class="fas fa-exclamation-triangle me-2"></i>Error(s):</strong>
                <ul>
                    <?php foreach ($errors as $error): ?>
                        <li><?php echo htmlspecialchars($error); ?></li>
                    <?php endforeach; ?>
                </ul>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <?php endif; ?>

        <!-- Member Selection Form -->
        <div class="card mb-4">
            <div class="card-header bg-navy text-white">
                <h4 class="mb-0"><i class="fas fa-user me-2"></i>Select Member</h4>
            </div>
            <div class="card-body">
                <form id="memberLookupForm" class="row g-3 align-items-end">
                    <div class="col-md-6">
                        <label for="lookup_member_id" class="form-label">Member ID</label>
                        <input type="text" class="form-control" id="lookup_member_id" placeholder="Enter Member ID">
                    </div>
                    <div class="col-md-6">
                        <button type="button" id="lookupMemberBtn" class="btn btn-navy">
                            <i class="fas fa-search me-2"></i>Look Up Fees
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Outstanding Fees Section -->
        <div class="card mb-4" id="outstandingFeesCard" style="display: none;">
            <div class="card-header bg-navy text-white">
                <h4 class="mb-0"><i class="fas fa-list-alt me-2"></i>Outstanding Fees</h4>
            </div>
            <div class="card-body">
                <div id="memberInfo" class="mb-3 pb-3 border-bottom"></div>
                <div id="feesList" class="fee-list">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Select</th>
                                <th>Fee Type</th>
                                <th>Semester</th>
                                <th>School Year</th>
                                <th>Amount (₱)</th>
                            </tr>
                        </thead>
                        <tbody id="feesTableBody">
                            <!-- Fee rows will be populated here -->
                        </tbody>
                    </table>
                </div>
                <div class="mt-3">
                    <button type="button" id="selectFeesBtn" class="btn btn-navy">
                        <i class="fas fa-check-square me-2"></i>Pay Selected Fees
                    </button>
                </div>
            </div>
        </div>

        <!-- Payment Form -->
        <div class="card mb-4">
            <div class="card-header bg-navy text-white">
                <h4 class="mb-0"><i class="fas fa-plus-circle me-2"></i>Add Payments</h4>
            </div>
            <div class="card-body">
                <form method="POST" action="add_payments.php" id="paymentForm" novalidate>
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label for="member_id" class="form-label">Member ID</label>
                            <input type="text" class="form-control" id="member_id" name="member_id" required>
                        </div>
                    </div>

                    <div id="paymentFields">
                        <div class="payment-entry row mb-3">
                            <div class="col-md-3">
                                <label class="form-label">Payment Amount (₱)</label>
                                <input type="number" class="form-control" name="amount[]" min="0" step="0.01" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Semester</label>
                                <select class="form-select" name="semester[]" required>
                                    <option value="1st Semester">1st Semester</option>
                                    <option value="2nd Semester">2nd Semester</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">School Year</label>
                                <input type="text" class="form-control" name="school_year[]" required>
                            </div>
                            <div class="col-md-3 d-flex align-items-end">
                                <button type="button" class="btn btn-danger remove-payment">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                        </div>
                    </div>

                    <button type="button" class="btn btn-success" id="addPayment">
                        <i class="fas fa-plus-circle me-2"></i>Add Another Payment
                    </button>

                    <button type="submit" class="btn btn-navy">
                        <i class="fas fa-save me-1"></i>Record Payments
                    </button>
                </form>
            </div>
        </div>
    </main>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById("addPayment").addEventListener("click", function() {
            let paymentFields = document.getElementById("paymentFields");
            let newEntry = document.createElement("div");
            newEntry.classList.add("payment-entry", "row", "mb-3");
            newEntry.innerHTML = `
                <div class="col-md-3">
                    <label class="form-label">Payment Amount (₱)</label>
                    <input type="number" class="form-control" name="amount[]" min="0" step="0.01" required>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Semester</label>
                    <select class="form-select" name="semester[]" required>
                        <option value="1st Semester">1st Semester</option>
                        <option value="2nd Semester">2nd Semester</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label">School Year</label>
                    <input type="text" class="form-control" name="school_year[]" required>
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <button type="button" class="btn btn-danger remove-payment"><i class="fas fa-trash"></i></button>
                </div>
            `;
            paymentFields.appendChild(newEntry);
        });

        document.addEventListener("click", function(event) {
            if (event.target.classList.contains("remove-payment") || 
                event.target.parentElement.classList.contains("remove-payment")) {
                const paymentEntries = document.querySelectorAll(".payment-entry");
                if (paymentEntries.length > 1) {
                    event.target.closest(".payment-entry").remove();
                } else {
                    alert("You must have at least one payment entry.");
                }
            }
        });

        document.addEventListener("DOMContentLoaded", function() {
            // Auto-dismiss alerts after delay
            setTimeout(function() {
                let alertBox = document.querySelector(".alert");
                if (alertBox) {
                    alertBox.style.transition = "opacity 0.5s";
                    alertBox.style.opacity = "0";
                    setTimeout(() => alertBox.style.display = "none", 500);
                }
            }, 2500); // 2.5 seconds delay

            // Member lookup functionality
            document.getElementById("lookupMemberBtn").addEventListener("click", function() {
                const memberId = document.getElementById("lookup_member_id").value.trim();
                if (!memberId) {
                    alert("Please enter a Member ID");
                    return;
                }

                // Set the member ID in the payment form
                document.getElementById("member_id").value = memberId;

                // AJAX call to get member fees
                fetch(`get_member_fees.php?member_id=${memberId}`)
                    .then(response => response.json())
                    .then(data => {
                        if (data.error) {
                            alert(data.error);
                            return;
                        }

                        // Display member info
                        document.getElementById("memberInfo").innerHTML = `
                            <h5>Member: ${data.member_name} (ID: ${data.member_id})</h5>
                        `;

                        // Clear existing fee rows
                        const feesTableBody = document.getElementById("feesTableBody");
                        feesTableBody.innerHTML = "";

                        // Add fee rows
                        if (data.fees.length === 0) {
                            feesTableBody.innerHTML = `<tr><td colspan="5" class="text-center">No outstanding fees found</td></tr>`;
                        } else {
                            data.fees.forEach(fee => {
                                feesTableBody.innerHTML += `
                                    <tr>
                                        <td><input type="checkbox" class="fee-checkbox" 
                                            data-fee-id="${fee.fee_type}" 
                                            data-amount="${fee.fee_amount}" 
                                            data-semester="${fee.semester}" 
                                            data-school-year="${fee.school_year}"></td>
                                        <td>${fee.fee_type}</td>
                                        <td>${fee.semester}</td>
                                        <td>${fee.school_year}</td>
                                        <td>₱${fee.fee_amount}</td>
                                    </tr>
                                `;
                            });
                        }

                        // Show fees section
                        document.getElementById("outstandingFeesCard").style.display = "block";
                    })
                    .catch(error => {
                        console.error("Error fetching fees:", error);
                        alert("Error fetching member fees. Please try again.");
                    });
            });

            // Handle selecting fees for payment
            document.getElementById("selectFeesBtn").addEventListener("click", function() {
                const selectedFees = document.querySelectorAll(".fee-checkbox:checked");
                
                if (selectedFees.length === 0) {
                    alert("Please select at least one fee to pay");
                    return;
                }

                // Clear existing payment fields
                const paymentFields = document.getElementById("paymentFields");
                paymentFields.innerHTML = "";

                // Add payment entries for each selected fee
                selectedFees.forEach((checkbox, index) => {
                    const amount = checkbox.getAttribute("data-amount");
                    const semester = checkbox.getAttribute("data-semester");
                    const schoolYear = checkbox.getAttribute("data-school-year");

                    const newEntry = document.createElement("div");
                    newEntry.classList.add("payment-entry", "row", "mb-3");
                    newEntry.innerHTML = `
                        <div class="col-md-3">
                            <label class="form-label">Payment Amount (₱)</label>
                            <input type="number" class="form-control" name="amount[]" min="0" step="0.01" value="${amount}" required>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Semester</label>
                            <select class="form-select" name="semester[]" required>
                                <option value="1st Semester" ${semester === '1st Semester' ? 'selected' : ''}>1st Semester</option>
                                <option value="2nd Semester" ${semester === '2nd Semester' ? 'selected' : ''}>2nd Semester</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">School Year</label>
                            <input type="text" class="form-control" name="school_year[]" value="${schoolYear}" required>
                        </div>
                        <div class="col-md-3 d-flex align-items-end">
                            <button type="button" class="btn btn-danger remove-payment"><i class="fas fa-trash"></i></button>
                        </div>
                    `;
                    paymentFields.appendChild(newEntry);
                });

                // Scroll to payment form
                document.getElementById("paymentForm").scrollIntoView({ behavior: 'smooth' });
            });
        });
    </script>

    <!-- Include footer -->
    <?php include('footer.php'); ?>
</body>
</html>