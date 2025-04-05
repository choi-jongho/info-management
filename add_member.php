<?php
    // Start session
    session_start();

    // Check if officer is logged in
    $officer_id = $_SESSION['officer_id'] ?? null;
    if (!$officer_id) {
        // Officer not logged in, redirect to login page
        header("Location: login.php");
        exit();
    }
    
    // Include database connection
    include('database.php');
    require_once('functions.php');
    require 'vendor/autoload.php'; // Include PhpSpreadsheet

    use PhpOffice\PhpSpreadsheet\IOFactory;

    // Check if officer is logged in
    $officer_id = $_SESSION['officer_id'] ?? null;
    if (!$officer_id) {
        // Officer not logged in, redirect to login page
        header("Location: login.php");
        exit();
    }

    // Handle form submission
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        try {
            // Handle file upload
            $target_dir = "uploads/";
            if (!is_dir($target_dir)) {
                mkdir($target_dir, 0777, true);
            }
            $target_file = $target_dir . basename($_FILES["fileToUpload"]["name"]);
            $uploadOk = 1;
            $fileType = pathinfo($target_file, PATHINFO_EXTENSION);

            // Check if file is a valid Excel file
            if ($fileType != "xls" && $fileType != "xlsx") {
                $errors[] = "Sorry, only XLS and XLSX files are allowed.";
                $uploadOk = 0;
            }

            if ($uploadOk == 1) {
                if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
                    // Process the uploaded file
                    $import_results = processExcelFile($target_file);
                    if ($import_results['success'] > 0) {
                        $_SESSION['success_message'] = "Excel import completed: {$import_results['success']} members added successfully.";
                    }
                    if ($import_results['errors'] > 0) {
                        $_SESSION['error_message'] = "{$import_results['errors']} records had errors and were skipped.";
                    }
                    header("Location: members.php");
                    exit();
                } else {
                    $errors[] = "Sorry, there was an error uploading your file.";
                }
            }

            // Get form data and sanitize
            $member_id = cleanInput($_POST['member_id'] ?? '');
            $last_name = cleanInput($_POST['last_name'] ?? '');
            $first_name = cleanInput($_POST['first_name'] ?? '');
            $middle_name = cleanInput($_POST['middle_name'] ?? '');
            $contact_num = cleanInput($_POST['contact_num'] ?? '');
            $email = cleanInput($_POST['email'] ?? '');
            $status = isset($_POST['status']) ? strtolower(cleanInput($_POST['status'])) : 'inactive'; // Default value;

            // Validate input
            $errors = [];

            // Basic validation
            if (empty($member_id) || empty($last_name) || empty($first_name)) {
                $errors[] = "Member ID, Last name, and First name are required fields.";
            }

            // Check if member_id already exists
            $check_query = "SELECT member_id FROM members WHERE member_id = ?";
            $stmt = $conn->prepare($check_query);
            $stmt->bind_param("s", $member_id);
            $stmt->execute();
            $result = $stmt->get_result();
            if ($result->num_rows > 0) {
                $errors[] = "Member ID already exists. Please use a different ID.";
            }
            $stmt->close();

            // If no errors, proceed with insertion
            if (empty($errors)) {
                // Insert into `members` table
                $sql = "INSERT INTO members (member_id, last_name, first_name, middle_name, contact_num, email, status)
                        VALUES (?, ?, ?, ?, ?, ?, ?)";
                $stmt = $conn->prepare($sql);
                $stmt->bind_param("sssssss", $member_id, $last_name, $first_name, $middle_name, $contact_num, $email, $status);
            
                if ($stmt->execute()) {
                    $stmt->close();
            
                    // Log activity for member addition
                    log_activity("Add Member", "Added member: $first_name $last_name (ID: $member_id)", $officer_id);
            
                    // Success message and redirect
                    $_SESSION['success_message'] = "Member added successfully!";
                    header("Location: members.php");
                    exit();
                } else {
                    $errors[] = "Database error (members): " . $stmt->error;
                }
            }
        } catch (Exception $e) {
            $errors[] = "An error occurred: " . $e->getMessage();
        }
    }

    function processExcelFile($filePath) {
        global $conn, $officer_id;
        $results = ['success' => 0, 'errors' => 0];
        
        try {
            $spreadsheet = IOFactory::load($filePath);
            $sheet = $spreadsheet->getActiveSheet();
            
            // Get highest row and column
            $highestRow = $sheet->getHighestRow();
            
            // Skip header row (starting from row 2)
            for ($row = 2; $row <= $highestRow; $row++) {
                // Read cell values directly
                $member_id = cleanInput($sheet->getCell('A'.$row)->getValue());
                $last_name = cleanInput($sheet->getCell('B'.$row)->getValue());
                $first_name = cleanInput($sheet->getCell('C'.$row)->getValue());
                $middle_name = cleanInput($sheet->getCell('D'.$row)->getValue());
                $contact_num = cleanInput($sheet->getCell('E'.$row)->getValue());
                $email = cleanInput($sheet->getCell('F'.$row)->getValue());
                $status = strtolower(cleanInput($sheet->getCell('G'.$row)->getValue()));
                
                // Handle numeric values properly for balance
                $balance_val = $sheet->getCell('H'.$row)->getValue();
                $balance = is_numeric($balance_val) ? $balance_val : 0;
                
                $semester = cleanInput($sheet->getCell('I'.$row)->getValue());

                // CRITICAL: Skip rows with empty or invalid required fields
                if (empty($member_id) || empty($last_name) || empty($first_name)) {
                    $results['errors']++;
                    continue;
                }

                // Check if member_id already exists
                $check_query = "SELECT member_id FROM members WHERE member_id = ?";
                $stmt = $conn->prepare($check_query);
                $stmt->bind_param("s", $member_id);
                $stmt->execute();
                $check_result = $stmt->get_result();
                if ($check_result->num_rows > 0) {
                    $results['errors']++;
                    $stmt->close();
                    continue; // Skip duplicate entries
                }
                $stmt->close();

                // Use prepared statement for insertion to avoid SQL injection and handle special characters
                $sql = "INSERT INTO members (member_id, last_name, first_name, middle_name, contact_num, email, status) 
                        VALUES (?, ?, ?, ?, ?, ?, ?)";
                
                $stmt = $conn->prepare($sql);
                $stmt->bind_param("sssssss", $member_id, $last_name, $first_name, $middle_name, $contact_num, $email, $status);
                
                if ($stmt->execute()) {
                    // Log successful import
                    $member_name = "$first_name $last_name";
                    log_activity("Import Member", "Imported member: $member_name (ID: $member_id)", $officer_id);
                    $results['success']++;
                } else {
                    $results['errors']++;
                }
                $stmt->close();
            }
        } catch (Exception $e) {
            $results['errors']++;
            $_SESSION['error_message'] = "Error processing Excel file: " . $e->getMessage();
        }

        return $results;
    }

    // Improved function to clean and sanitize input data
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
            background-color: #004080 !important; /* Slightly lighter navy on hover */
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
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <?php endif; ?>

        <div class="form-container">
            <form method="POST" action="" enctype="multipart/form-data" novalidate>
                
                <!-- File Upload -->
                <div class="row mb-4">
                    <div class="col-md-4 mb-3">
                        <label for="fileToUpload" class="form-label">If a list of members is available, upload it here</label>
                        <input type="file" class="form-control" id="fileToUpload" name="fileToUpload" accept=".xls,.xlsx">
                        <div class="form-text">File should be in xls or xlsx format</div>
                    </div>
                </div>

                <div class="row mb-4">
                    <div class="col-md-3 mb-3">
                        <label for="member_id" class="form-label required-field">Member ID</label>
                        <input type="text" class="form-control" id="member_id" name="member_id" value="<?php echo isset($_POST['member_id']) ? htmlspecialchars($_POST['member_id']) : ''; ?>" required>
                        <div class="form-text">Unique identifier for the member</div>
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
</body>
</html>