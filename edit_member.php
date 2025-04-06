<?php
    require_once('database.php');
    require_once('functions.php');
    
    // Assume the officer is logged in and their ID is stored in the session
    session_start();
    $officer_id = $_SESSION['officer_id'] ?? null;

    if (!$officer_id) {
        // Officer not logged in, redirect to login page
        header("Location: login.php");
        exit();
    }
    
    // Check if ID is provided
    if (!isset($_GET['id']) || empty($_GET['id'])) {
        header("Location: members.php");
        exit();
    }
    
    $member_id = sanitize_input($_GET['id']);
    $errors = [];
    $success = false;
    
    // Get member details
    $stmt = $conn->prepare("SELECT * FROM members WHERE member_id = ?");
    $stmt->bind_param("s", $member_id);
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($result->num_rows === 0) {
        // Member not found, redirect to members page
        header("Location: members.php?error=notfound");
        exit();
    }
    
    $member = $result->fetch_assoc();
    $stmt->close();

    // Get fee-related data from the `fees` table
    $stmt = $conn->prepare("
        SELECT 
            COALESCE(SUM(f.fee_amount), 0) AS total_fee_amount,
            COUNT(DISTINCT f.semester) AS semester_count,
            COUNT(DISTINCT f.school_year) AS school_year_count
        FROM fees f
        WHERE f.member_id = ?
    ");
    $stmt->bind_param("s", $member_id);
    $stmt->execute();
    $result = $stmt->get_result();
    $fee_data = $result->fetch_assoc();
    $stmt->close();

    // Merge fee details with the existing member data
    $member['total_fee_amount'] = $fee_data['total_fee_amount'] ?? 0;
    $member['semester_count'] = $fee_data['semester_count'] ?? 0;
    $member['school_year_count'] = $fee_data['school_year_count'] ?? 0;
    
    // Handle form submission
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        // Validate inputs
        $last_name = sanitize_input($_POST['last_name'] ?? '');
        $first_name = sanitize_input($_POST['first_name'] ?? '');
        $middle_name = sanitize_input($_POST['middle_name'] ?? '');
        $contact_num = sanitize_input($_POST['contact_num'] ?? '');
        $email = sanitize_input($_POST['email'] ?? '');
        $status = sanitize_input($_POST['status'] ?? '');
        $balance = sanitize_input($_POST['balance'] ?? '0');
        $semester_count = sanitize_input($_POST['semester_count'] ?? '1');
        $school_year_count = sanitize_input($_POST['school_year_count'] ?? '1');
    
        // Perform validation
        if (empty($last_name)) {
            $errors[] = "Last name is required";
        }
        
        if (empty($first_name)) {
            $errors[] = "First name is required";
        }
        
        if (empty($contact_num)) {
            $errors[] = "Contact number is required";
        }
        
        if (empty($email)) {
            $errors[] = "Email is required";
        } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $errors[] = "Invalid email format";
        }
        
        // Ensure numeric values
        if (!is_numeric($balance) || $balance < 0) {
            $errors[] = "Balance must be a positive number.";
        }
        if (!is_numeric($semester_count) || $semester_count < 1) {
            $errors[] = "Total semesters must be at least 1.";
        }
        if (!is_numeric($school_year_count) || $school_year_count < 1) {
            $errors[] = "Total school years must be at least 1.";
        }
        
        // If no errors, update data
        if (empty($errors)) {
            try {
                // Use prepared statement to prevent SQL injection for member updates
                $stmt = $conn->prepare("
                    UPDATE members 
                    SET last_name = ?, first_name = ?, middle_name = ?, contact_num = ?, email = ?, status = ? 
                    WHERE member_id = ?
                ");
                $stmt->bind_param("sssssss", $last_name, $first_name, $middle_name, $contact_num, $email, $status, $member_id);
        
                if ($stmt->execute()) {
                    $stmt->close();
        
                    // Fetch existing fee amount before update
                    $stmt = $conn->prepare("SELECT fee_amount FROM fees WHERE member_id = ?");
                    $stmt->bind_param("s", $member_id);
                    $stmt->execute();
                    $stmt->bind_result($existing_fee_amount);
                    $stmt->fetch();
                    $stmt->close();

                    // Ensure fee amount is preserved if not explicitly modified in the form
                    $fee_amount = !empty($_POST['fee_amount']) && is_numeric($_POST['fee_amount']) ? $_POST['fee_amount'] : $existing_fee_amount;

                    // Update fee details while keeping existing fee amount intact
                    $stmt = $conn->prepare("
                        UPDATE fees 
                        SET fee_amount = ?, semester = ?, school_year = ? 
                        WHERE member_id = ?
                    ");
                    $stmt->bind_param("dsss", $fee_amount, $semester_count, $school_year_count, $member_id);

                    if ($stmt->execute()) {
                        $success = true;
                        $member_name = "$first_name $last_name";
                        log_activity('Update Member', "Updated member: $member_name (ID: $member_id)", $officer_id);
                        $_SESSION['success_message'] = "Member information updated successfully!";
                        // Redirect upon success
                        header("Location: members.php");
                        exit();
                    } else {
                        throw new Exception("Database error when updating fees: " . $stmt->error);
                    }
                } else {
                    throw new Exception("Database error when updating member: " . $stmt->error);
                }
        
                $stmt->close();
            } catch (Exception $e) {
                $errors[] = "Error: " . $e->getMessage();
            }
        }
    }
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Member | INTEL</title>
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
            background-color: #003366;
            border-color: #003366;
            color: #fff;
        }
</style>
<body>
    <!-- Include the navigation bar -->
    <?php include('navbar.php'); ?>

    <!-- Main Content -->
    <main class="container my-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-user-edit me-2"></i>Edit Member</h2>
            <a href="view_member.php?id=<?php echo urlencode($member_id); ?>" class="btn btn-secondary">
                <i class="fas fa-arrow-left me-2"></i>Back to Member Details
            </a>
        </div>
        
        <div class="card shadow">
            <div class="card-header bg-navy text-white">
                <h4 class="mb-0">
                    <i class="fas fa-edit me-2"></i>Edit: <?php echo htmlspecialchars(format_name($member['first_name'], $member['last_name'], $member['middle_name'])); ?>
                </h4>
            </div>
            <div class="card-body">
                <?php if ($success): ?>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>Member information updated successfully!
                    </div>
                <?php endif; ?>
                
                <?php if (!empty($errors)): ?>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <strong><i class="fas fa-exclamation-triangle me-2"></i>Please correct the following errors:</strong>
                        <ul class="mb-0 mt-2">
                            <?php foreach ($errors as $error): ?>
                                <li><?php echo $error; ?></li>
                            <?php endforeach; ?>
                        </ul>
                    </div>
                <?php endif; ?>
                
                <form method="POST" action="" class="needs-validation" novalidate>
                    <div class="row mb-4">
                        <div class="col-md-3 mb-3">
                            <label for="member_id" class="form-label">Member ID</label>
                            <input type="text" class="form-control" id="member_id" value="<?php echo htmlspecialchars($member['member_id']); ?>" readonly disabled>
                            <div class="form-text text-muted">Member ID cannot be changed</div>
                        </div>

                        <div class="col-md-3 mb-3">
                            <label for="last_name" class="form-label">Last Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="last_name" name="last_name" 
                                value="<?php echo htmlspecialchars($member['last_name']); ?>" required>
                        </div>

                        <div class="col-md-3 mb-3">
                            <label for="first_name" class="form-label">First Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="first_name" name="first_name" 
                                value="<?php echo htmlspecialchars($member['first_name']); ?>" required>
                        </div>

                        <div class="col-md-3 mb-3">
                            <label for="middle_name" class="form-label">Middle Name</label>
                            <input type="text" class="form-control" id="middle_name" name="middle_name" 
                                value="<?php echo htmlspecialchars($member['middle_name']); ?>">
                        </div>
                    </div>

                    <div class="row mb-4">
                        <div class="col-md-4 mb-3">
                            <label for="contact_num" class="form-label">Contact Number <span class="text-danger">*</span></label>
                            <input type="tel" class="form-control" id="contact_num" name="contact_num" 
                                value="<?php echo htmlspecialchars($member['contact_num']); ?>" required>
                        </div>

                        <div class="col-md-4 mb-3">
                            <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" id="email" name="email" 
                                value="<?php echo htmlspecialchars($member['email']); ?>" required>
                        </div>

                        <div class="col-md-4 mb-3">
                            <label for="status" class="form-label">Status <span class="text-danger">*</span></label>
                            <select class="form-select" id="status" name="status" required>
                                <option value="Active" <?php echo $member['status'] === 'Active' ? 'selected' : ''; ?>>Active</option>
                                <option value="Inactive" <?php echo $member['status'] === 'Inactive' ? 'selected' : ''; ?>>Inactive</option>
                            </select>
                        </div>
                    </div>

                    <!-- Buttons Section -->
                    <div class="d-flex justify-content-end mt-4">
                        <a href="members.php" class="btn btn-secondary me-2">
                            <i class="fas fa-arrow-left me-1"></i> Cancel
                        </a>
                        <button type="submit" class="btn btn-navy">
                            <i class="fas fa-save me-1"></i> Save Changes
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-navy text-white text-center py-3 mt-auto">
        <p class="mb-0">&copy; 2025 Information Technology Link | All Rights Reserved</p>
    </footer>
    <!-- Bootstrap JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
                document.addEventListener("DOMContentLoaded", function() {
            setTimeout(function() {
                let alertBox = document.querySelector(".alert");
                if (alertBox) {
                    alertBox.style.transition = "opacity 0.5s";
                    alertBox.style.opacity = "0";
                    setTimeout(() => alertBox.style.display = "none", 500);
                }
            }, 2500); // 2.5 seconds delay
        });
    </script>
</body>
</html>
