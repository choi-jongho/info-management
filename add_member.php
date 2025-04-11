<?php
    // Start session
    session_start();

    // Check if officer is logged in
    $officer_id = $_SESSION['officer_id'] ?? null;
    if (!$officer_id) {
        header("Location: login.php");
        exit();
    }

    // Include dependencies
    include('database.php');
    require_once('functions.php');
    require 'vendor/autoload.php'; // Include PhpSpreadsheet
    use PhpOffice\PhpSpreadsheet\IOFactory;

    // Handle form submission (Members + Fees)
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $errors = [];
    
        // Check if file upload is happening
        if (isset($_FILES["fileToUpload"]) && $_FILES["fileToUpload"]["size"] > 0) {
            try {
                $target_dir = "uploads/";
                if (!is_dir($target_dir)) {
                    mkdir($target_dir, 0777, true);
                }
                $target_file = $target_dir . basename($_FILES["fileToUpload"]["name"]);
                $fileType = pathinfo($target_file, PATHINFO_EXTENSION);
    
                // Validate file type
                if (!in_array($fileType, ["xls", "xlsx"])) {
                    $errors[] = "Only XLS and XLSX files are allowed.";
                }
    
                // Process the file if no errors
                if (empty($errors) && move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
                    $import_results = processExcelFile($target_file);
                    
                    if ($import_results['success'] > 0) {
                        $_SESSION['success_message'] = "{$import_results['success']} records imported successfully.";
                        header("Location: members.php");
                        exit();
                    }
                    
                    if ($import_results['duplicates'] > 0) {
                        $_SESSION['warning_message'] = "{$import_results['duplicates']} members already exist and were skipped:<br>" . implode("<br>", $import_results['duplicateMembers']);
                        header("Location: members.php");
                        exit();
                    }
    
                    if ($import_results['errors'] > 0) {
                        $errors[] = "{$import_results['errors']} records had errors.";
                        // Don't redirect, stay on the page to show errors
                    }
                } else {
                    $errors[] = "Error uploading the file.";
                }
            } catch (Exception $e) {
                $errors[] = "Error processing the file: " . $e->getMessage();
            }
        }
    
        // If a form submission for manual entry is happening (without file upload)
        if (!isset($_FILES["fileToUpload"]) || $_FILES["fileToUpload"]["size"] == 0) {
            // Validate form inputs (only when form fields are submitted)
            $member_id = cleanInput($_POST['member_id'] ?? '');
            $last_name = cleanInput($_POST['last_name'] ?? '');
            $first_name = cleanInput($_POST['first_name'] ?? '');
            $middle_name = cleanInput($_POST['middle_name'] ?? '');
            $contact_num = cleanInput($_POST['contact_num'] ?? '');
            $email = cleanInput($_POST['email'] ?? '');
            $status = strtolower(cleanInput($_POST['status'] ?? ''));
            $status = ($status == 'active') ? 'Active' : 'Inactive'; // Normalize status
            $fee_type = cleanInput($_POST['fee_type'] ?? '');
            $fee_amount = floatval(cleanInput($_POST['fee_amount'] ?? 0));
            $semester = cleanInput($_POST['semester'] ?? '');
            $school_year = cleanInput($_POST['school_year'] ?? '');
    
            if (empty($member_id) || empty($last_name) || empty($first_name) || empty($fee_type) || $fee_amount <= 0 || empty($semester) || empty($school_year)) {
                $errors[] = "Required fields are missing.";
            } elseif (!preg_match('/^\d{4}-\d{4}$/', $school_year)) {
                $errors[] = "School year must be in the format 0000-0000.";
            } else {
                // Additional validation to ensure it's strictly in 0000-0000 format
                $years = explode('-', $school_year);
                if (count($years) !== 2 || strlen($years[0]) !== 4 || strlen($years[1]) !== 4) {
                    $errors[] = "School year must be in the format 0000-0000.";
                }
            }
    
            // If no errors, proceed with inserting manually entered data
            if (empty($errors)) {
                // First insert the member
                $stmt = $conn->prepare("INSERT INTO members (member_id, last_name, first_name, middle_name, contact_num, email, status) VALUES (?, ?, ?, ?, ?, ?, ?)");
                $stmt->bind_param("sssssss", $member_id, $last_name, $first_name, $middle_name, $contact_num, $email, $status);
                
                if ($stmt->execute()) {
                    log_activity("Add Member", "Added member: $first_name $last_name (ID: $member_id)", $officer_id);
                    $stmt->close();
    
                    // Then insert the fee
                    $stmt = $conn->prepare("INSERT INTO fees (member_id, fee_amount, fee_type, semester, school_year, status) VALUES (?, ?, ?, ?, ?, 'Unpaid')");
                    $stmt->bind_param("sdsss", $member_id, $fee_amount, $fee_type, $semester, $school_year);
                    
                    if ($stmt->execute()) {
                        $_SESSION['success_message'] = "Member and Fee added successfully!";
                        header("Location: members.php");
                        exit();
                    } else {
                        $errors[] = "Error adding fee: " . $stmt->error;
                    }
                } else {
                    $errors[] = "Error adding member: " . $stmt->error;
                }
            }
        }
    
        // If we've reached here, there were errors
        if (!empty($errors)) {
            $_SESSION['error_message'] = implode("<br>", $errors);
        }
    }

    // Function to process bulk member and fee import from Excel
    function processExcelFile($filePath) {
        global $conn, $officer_id;
        $results = ['success' => 0, 'errors' => 0, 'duplicates' => 0, 'duplicateMembers' => []];
    
        try {
            $spreadsheet = IOFactory::load($filePath);
            $sheet = $spreadsheet->getActiveSheet();
            $highestRow = $sheet->getHighestRow();
    
            for ($row = 2; $row <= $highestRow; $row++) {
                $member_id = cleanInput($sheet->getCell('A'.$row)->getValue());
                $last_name = cleanInput($sheet->getCell('B'.$row)->getValue());
                $first_name = cleanInput($sheet->getCell('C'.$row)->getValue());
                $middle_name = cleanInput($sheet->getCell('D'.$row)->getValue());
                $contact_num = cleanInput($sheet->getCell('E'.$row)->getValue());
                $email = cleanInput($sheet->getCell('F'.$row)->getValue());
                $status = strtolower(cleanInput($sheet->getCell('G'.$row)->getValue()));
                $status = ($status == 'active') ? 'Active' : 'Inactive'; // Normalize status
    
                // Fee-related columns
                $fee_type = cleanInput($sheet->getCell('H'.$row)->getValue());
                $fee_amount = floatval(cleanInput($sheet->getCell('I'.$row)->getValue()));
                $semester = cleanInput($sheet->getCell('J'.$row)->getValue());
                $school_year = cleanInput($sheet->getCell('K'.$row)->getValue());
    
                // Validate required fields
                if (empty($member_id) || empty($last_name) || empty($first_name) || empty($fee_type) || $fee_amount <= 0 || empty($semester) || empty($school_year)) {
                    $results['errors']++;
                    continue;
                }
    
                // Validate school year format - strict 0000-0000 format
                if (!preg_match('/^\d{4}-\d{4}$/', $school_year)) {
                    $results['errors']++;
                    continue;
                }
    
                // Check for duplicate members
                $stmt = $conn->prepare("SELECT member_id FROM members WHERE member_id = ?");
                $stmt->bind_param("s", $member_id);
                $stmt->execute();
                $check_result = $stmt->get_result();
    
                if ($check_result->num_rows > 0) {
                    // Store duplicate members for warning
                    $results['duplicates']++;
                    $results['duplicateMembers'][] = "$first_name $last_name (ID: $member_id)";
                    $stmt->close();
                    continue; // Skip duplicates
                }
                $stmt->close();
    
                // Insert member
                $stmt = $conn->prepare("INSERT INTO members (member_id, last_name, first_name, middle_name, contact_num, email, status) VALUES (?, ?, ?, ?, ?, ?, ?)");
                $stmt->bind_param("sssssss", $member_id, $last_name, $first_name, $middle_name, $contact_num, $email, $status);
    
                if ($stmt->execute()) {
                    log_activity("Import Member", "Imported member: $first_name $last_name (ID: $member_id)", $officer_id);
    
                    // Insert fee for this member
                    $stmt = $conn->prepare("INSERT INTO fees (member_id, fee_amount, fee_type, semester, school_year, status) VALUES (?, ?, ?, ?, ?, 'Unpaid')");
                    $stmt->bind_param("sdsss", $member_id, $fee_amount, $fee_type, $semester, $school_year);
                    $stmt->execute();
    
                    $results['success']++;
                } else {
                    $results['errors']++;
                }
                $stmt->close();
            }

            // Set success message only if at least one member was added
            if ($results['success'] > 0) {
                $_SESSION['success_message'] = "{$results['success']} new members added successfully.";
            }

            // Set warning message for duplicates
            if ($results['duplicates'] > 0) {
                $_SESSION['warning_message'] = "{$results['duplicates']} members were already in the system and skipped:<br>" . implode("<br>", $results['duplicateMembers']);
            }

            // Set error message if there were errors
            if ($results['errors'] > 0) {
                $_SESSION['error_message'] = "{$results['errors']} records had errors.";
            }

            // Return results instead of redirecting
            return $results;

        } catch (Exception $e) {
            $results['errors']++;
            $results['error_message'] = "Error processing Excel file: " . $e->getMessage();
            return $results;
        }
    }

    function cleanInput($input) {
        if ($input === null) {
            return '';
        }
        
        if (!is_string($input)) {
            // Convert non-string values to string
            $input = (string)$input;
        }
        
        // Remove BOM and non-printable characters
        $input = preg_replace('/[\x00-\x1F\x80-\xFF]/', '', $input);
        
        // Remove commas to prevent SQL issues
        $input = str_replace(',', '', $input);
        
        // Trim whitespace and quotes (which can come from Excel)
        $input = trim($input, " \t\n\r\0\x0B\"'");
        
        return $input;
    }
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Meta and Title -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Member | INTEL</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="icon" href="images/info-tech.svg">
    <!-- Custom Styles -->
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
            background-color: #001f3f !important;
            border-color: #001f3f !important;
            color: #fff;
        }
        .btn-navy:hover {
            background-color: #004080 !important;
            color: #fff;
        }
        .form-container {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            padding: 30px;
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
            <h1><i class="fas fa-users me-2"></i>Add New Member</h1>
            <a href="members.php" class="btn btn-outline-light">
                <i class="fas fa-arrow-left me-2"></i>Back to Members
            </a>
        </div>
    </header>

    <!-- Main Content -->
    <main class="container my-5">
        <!-- Error Messages Display -->
        <?php if(isset($errors) && !empty($errors)): ?>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <strong>Error!</strong>
                <ul class="mb-0">
                    <?php foreach($errors as $error): ?>
                        <li><?php echo $error; ?></li>
                    <?php endforeach; ?>
                </ul>
            </div>
        <?php endif; ?>

        <div class="form-container">
            <form method="POST" action="" enctype="multipart/form-data" novalidate>
                
                <!-- File Upload -->
                <div class="row mb-4">
                    <div class="col-md-4 mb-3">
                        <label for="fileToUpload" class="form-label">Upload member list</label>
                        <input type="file" class="form-control" id="fileToUpload" name="fileToUpload" accept=".xls,.xlsx">
                        <div class="form-text">File should be in xls or xlsx format</div>
                    </div>
                </div>

                <!-- Member Details -->
                <div class="row mb-4">
                    <div class="col-md-3 mb-3">
                        <label for="member_id" class="form-label required-field">Member ID</label>
                        <input type="text" class="form-control" id="member_id" name="member_id" value="<?php echo isset($_POST['member_id']) ? htmlspecialchars($_POST['member_id']) : ''; ?>" required>
                    </div>
                    <div class="col-md-3 mb-3">
                        <label for="last_name" class="form-label required-field">Last Name</label>
                        <input type="text" class="form-control" id="last_name" name="last_name" value="<?php echo isset($_POST['last_name']) ? htmlspecialchars($_POST['last_name']) : ''; ?>" required>
                    </div>
                    <div class="col-md-3 mb-3">
                        <label for="first_name" class="form-label required-field">First Name</label>
                        <input type="text" class="form-control" id="first_name" name="first_name" value="<?php echo isset($_POST['first_name']) ? htmlspecialchars($_POST['first_name']) : ''; ?>" required>
                    </div>
                    <div class="col-md-3 mb-3">
                        <label for="middle_name" class="form-label">Middle Name</label>
                        <input type="text" class="form-control" id="middle_name" name="middle_name" value="<?php echo isset($_POST['middle_name']) ? htmlspecialchars($_POST['middle_name']) : ''; ?>">
                    </div>
                </div>

                <!-- Status Selection -->
                <div class="row mb-4">
                    <div class="col-md-4 mb-3">
                        <label for="contact_num" class="form-label required-field">Contact Number</label>
                        <input type="tel" class="form-control" id="contact_num" name="contact_num" value="<?php echo isset($_POST['contact_num']) ? htmlspecialchars($_POST['contact_num']) : ''; ?>" required>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="email" class="form-label required-field">Email</label>
                        <input type="email" class="form-control" id="email" name="email" value="<?php echo isset($_POST['email']) ? htmlspecialchars($_POST['email']) : ''; ?>" required>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="status" class="form-label required-field">Status</label>
                        <select class="form-select" id="status" name="status" required>
                            <option value="" disabled <?php echo !isset($_POST['status']) ? 'selected' : ''; ?>>Select Status</option>
                            <option value="Active" <?php echo (isset($_POST['status']) && $_POST['status'] == 'Active') ? 'selected' : ''; ?>>Active</option>
                            <option value="Inactive" <?php echo (isset($_POST['status']) && $_POST['status'] == 'Inactive') ? 'selected' : ''; ?>>Inactive</option>
                        </select>
                    </div>
                </div>

                <!-- Fee Details -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <label for="fee_type" class="form-label required-field">Fee Type</label>
                        <input type="text" class="form-control" id="fee_type" name="fee_type" placeholder="INTEL FEE" value="<?php echo isset($_POST['fee_type']) ? htmlspecialchars($_POST['fee_type']) : ''; ?>" required>
                    </div>

                    <div class="col-md-3">
                        <label for="fee_amount" class="form-label required-field">Fee Amount</label>
                        <div class="input-group">
                            <span class="input-group-text">₱</span>
                            <input type="number" class="form-control" id="fee_amount" name="fee_amount" min="0" step="0.01" value="<?php echo isset($_POST['fee_amount']) ? htmlspecialchars($_POST['fee_amount']) : ''; ?>" required>
                        </div>
                    </div>
                    
                    <div class="col-md-3">
                        <label for="semester" class="form-label required-field">Semester</label>
                        <select class="form-select" id="semester" name="semester" required>
                            <option value="1st Semester" <?php echo (isset($_POST['semester']) && $_POST['semester'] == '1st Semester') ? 'selected' : ''; ?>>1st Semester</option>
                            <option value="2nd Semester" <?php echo (isset($_POST['semester']) && $_POST['semester'] == '2nd Semester') ? 'selected' : ''; ?>>2nd Semester</option>
                        </select>
                    </div>

                    <div class="col-md-3">
                        <label for="school_year" class="form-label required-field">School Year</label>
                        <input type="text" class="form-control" id="school_year" name="school_year" 
                               placeholder="0000-0000" pattern="\d{4}-\d{4}" 
                               title="Please enter in the format 0000-0000" 
                               value="<?php echo isset($_POST['school_year']) ? htmlspecialchars($_POST['school_year']) : ''; ?>" required>
                    </div>
                </div>

                <!-- Submit Buttons -->
                <div class="d-flex justify-content-end mt-4">
                    <a href="members.php" class="btn btn-secondary me-2">
                        <i class="fas fa-times me-1"></i> Cancel
                    </a>
                    <button type="submit" class="btn btn-navy">
                        <i class="fas fa-user-plus me-1"></i> Add Member
                    </button>
                </div>
            </form>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-navy text-white text-center py-3 mt-auto">
        <p class="mb-0">&copy; 2025 Information Technology Link | All Rights Reserved</p>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // Auto-dismiss alerts after 5 seconds
            setTimeout(function() {
                let alertBox = document.querySelector(".alert");
                if (alertBox) {
                    alertBox.style.transition = "opacity 0.5s";
                    alertBox.style.opacity = "0";
                    setTimeout(() => alertBox.remove(), 500);
                }
            }, 2500);

            const schoolYearInput = document.getElementById('school_year');
            
            schoolYearInput.addEventListener('input', function(e) {
                const value = e.target.value;
                
                // Only allow digits and a single hyphen
                if (!/^[0-9-]*$/.test(value)) {
                    e.target.value = value.replace(/[^0-9-]/g, '');
                }
                
                // Format as user types (after 4 digits, add hyphen)
                if (value.length === 4 && !value.includes('-')) {
                    e.target.value = value + '-';
                }
                
                // Limit to 9 characters (0000-0000)
                if (value.length > 9) {
                    e.target.value = value.slice(0, 9);
                }
                
                // Set custom validity for form validation
                const pattern = /^\d{4}-\d{4}$/;
                if (!pattern.test(e.target.value)) {
                    this.setCustomValidity('Please enter in the format 0000-0000');
                } else {
                    this.setCustomValidity('');
                }
            });
        });
    </script>
</body>
</html>