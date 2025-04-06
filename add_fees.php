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

    // Handle form submission
    if ($_SERVER["REQUEST_METHOD"] === "POST") {
        $semester = sanitize_input($_POST['semester'] ?? '');
        $school_year = sanitize_input($_POST['school_year'] ?? '');
        $fee_type = sanitize_input($_POST['fee_type'] ?? 'Standard Fee');
        $fee_amount = sanitize_input($_POST['fee_amount'] ?? '');

        // Validate inputs
        $errors = [];

        if (empty($semester)) {
            $errors[] = "Semester is required.";
        }
        if (empty($school_year)) {
            $errors[] = "School year is required.";
        }
        if (empty($fee_amount) || !is_numeric($fee_amount) || $fee_amount <= 0) {
            $errors[] = "Fee amount must be a positive number.";
        }

        if (empty($errors)) {
            try {
                $conn->begin_transaction();
        
                // Check if the member already has 2 school years recorded
                $stmt_check = $conn->prepare("
                    SELECT COUNT(DISTINCT school_year) FROM fees WHERE member_id = ?
                ");
                $stmt_check->bind_param("s", $member_id);
                $stmt_check->execute();
                $stmt_check->bind_result($existing_school_years);
                $stmt_check->fetch();
                $stmt_check->close();
        
                if ($existing_school_years < 2) {
                    // Insert fee **ONLY IF** the same semester does not already exist in that school year
                    $stmt = $conn->prepare("
                        INSERT INTO fees (member_id, fee_type, fee_amount, semester, school_year)
                        SELECT member_id, ?, ?, ?, ? FROM members
                        WHERE NOT EXISTS (
                            SELECT 1 FROM fees WHERE fees.member_id = members.member_id 
                            AND fees.school_year = ? 
                            AND fees.semester = ?
                        )
                    ");
        
                    $stmt->bind_param("sdssss", $fee_type, $fee_amount, $semester, $school_year, $school_year, $semester);
        
                    if ($stmt->execute()) {
                        $conn->commit(); // Commit transaction
                        $_SESSION['success_message'] = "Fees added successfully for eligible members!";
                        log_activity("Add Fees", "Added fee: $fee_type (₱$fee_amount) for Semester: $semester, SY: $school_year", $officer_id);
                    } else {
                        throw new Exception("Error adding fees: " . $stmt->error);
                    }
        
                    $stmt->close();
                } else {
                    $_SESSION['error_message'] = "Members already have fees for two school years.";
                }
            } catch (Exception $e) {
                $conn->rollback();
                $_SESSION['error_message'] = "Transaction failed: " . $e->getMessage();
            }
        } else {
            $_SESSION['error_message'] = implode("<br>", $errors);
        }
    }
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Add Fees | INTEL</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <!-- Custom CSS -->
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
            color: white !important;
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

        .form-container {
            background-color: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }
        .required-field::after {
            content: "*";
            color: red;
            margin-left: 4px;
        } 
    </style>
</head>
<body>
    <!-- Header -->
    <header class="bg-navy text-white py-3">
        <div class="container d-flex justify-content-between align-items-center">
            <h1 class="mb-0"><i class="fas fa-dollar-sign me-2"></i>Add Fees</h1>
            <a href="members.php" class="btn btn-outline-light">
                <i class="fas fa-arrow-left me-2"></i>Back to Members
            </a>
        </div>
    </header>

    <main class="container my-5">
        <div class="card">
            <div class="card-header bg-navy text-white">
                <h4 class="mb-0"><i class="fas fa-plus-circle me-2"></i>Add Fees</h4>
            </div>

            <div class="card-body form-container">
                <!-- Notifications -->
                <?php if (isset($_SESSION['success_message'])): ?>
                    <div class="alert alert-success"><?php echo $_SESSION['success_message']; unset($_SESSION['success_message']); ?></div>
                <?php endif; ?>

                <?php if (isset($_SESSION['error_message'])): ?>
                    <div class="alert alert-danger"><?php echo $_SESSION['error_message']; unset($_SESSION['error_message']); ?></div>
                <?php endif; ?>

                <form method="POST" action="" class="row g-3">

                    <div class="col-md-3">
                        <label for="fee_type" class="form-label required-field">Fee Type</label>
                        <input type="text" class="form-control" id="fee_type" name="fee_type" placeholder="Intel Fee" required>
                    </div>

                    <div class="col-md-3">
                        <label for="fee_amount" class="form-label required-field">Fee Amount</label>
                        <div class="input-group">
                            <span class="input-group-text">₱</span>
                            <input type="number" class="form-control" id="fee_amount" name="fee_amount" min="0" step="0.01" required>
                        </div>
                    </div>
                    
                    <div class="col-md-3">
                        <label for="semester" class="form-label required-field">Semester</label>
                        <select class="form-select" id="semester" name="semester" required>
                            <option value="1st Semester">1st Semester</option>
                            <option value="2nd Semester">2nd Semester</option>
                        </select>
                    </div>

                    <div class="col-md-3">
                        <label for="school_year" class="form-label required-field">School Year</label>
                        <input type="text" class="form-control" id="school_year" name="school_year" placeholder="2024-2025" required>
                    </div>

                    <div class="col-12 text-end">
                        <button type="submit" class="btn btn-navy">
                            <i class="fas fa-plus me-2"></i>Add Fees to All Members
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </main>
    
    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <?php include('footer.php'); ?>
</body>
</html>