<?php
    require_once('database.php');
    require_once('functions.php');

    // Start session
    session_start();

    // Check if user is logged in
    if (!isset($_SESSION['officer_id'])) {
        header("Location: login.php");
        exit();
    }

    $user_id = $_SESSION['officer_id'];
    $errors = [];
    $success = false;

    // Fetch user details
    $stmt = $conn->prepare("SELECT * FROM officers WHERE officer_id = ?");
    $stmt->bind_param("s", $user_id);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows === 0) {
        // User not found, redirect to login page
        header("Location: login.php?error=notfound");
        exit();
    }

    $user = $result->fetch_assoc();
    $stmt->close();

    // Fetch member details using officer_id
    $stmt = $conn->prepare("SELECT members.member_id, members.first_name, members.last_name, members.email, members.contact_num FROM officers JOIN members ON officers.member_id = members.member_id WHERE officers.officer_id = ?");
    $stmt->bind_param("s", $user_id);
    $stmt->execute();
    $member_result = $stmt->get_result();

    if ($member_result->num_rows > 0) {
        $member = $member_result->fetch_assoc();
    } else {
        $member = ['first_name' => 'Unknown', 'last_name' => 'Unknown'];
    }
    $stmt->close();

    // Handle form submission
    if ($_SERVER["REQUEST_METHOD"] === "POST") {
        $member_id = sanitize_input($_POST['member_id'] ?? '');
        $officer_id = sanitize_input($_POST['officer_id'] ?? '');
        $first_name = sanitize_input($_POST['first_name'] ?? '');
        $last_name = sanitize_input($_POST['last_name'] ?? '');

        // Validate inputs
        if (empty($member_id)) {
            $errors[] = "Member ID is required.";
        }

        if (empty($first_name)) {
            $errors[] = "First name is required.";
        }

        if (empty($last_name)) {
            $errors[] = "Last name is required.";
        }

        // If no errors, update data
        if (empty($errors)) {
            try {
                $stmt = $conn->prepare("UPDATE officers SET first_name = ?, last_name = ? WHERE officer_id = ?");
                $stmt->bind_param("sss", $first_name, $last_name, $user_id);

                if ($stmt->execute()) {
                    // Update member table
                    $stmt = $conn->prepare("UPDATE members SET first_name = ?, last_name = ? WHERE member_id = ?");
                    $stmt->bind_param("ss", $first_name, $last_name, $member_id);
                    $stmt->execute();
                    $stmt->close();

                    $success = true;
                    log_activity('Update Profile', "User updated their profile: $first_name $last_name", $user_id);
                    $_SESSION['success_message'] = "Profile updated successfully!";
                    header("Location: profile.php");
                    exit();
                } else {
                    $errors[] = "Database error: " . $stmt->error;
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
    <title>Profile | INTEL</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="icon" href="images/info-tech.png">
    <!-- Custom Styles -->
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        main {
            flex: 1;
        }
        .profile-container {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            padding: 30px;
            margin-top: 20px;
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
            border-color: #001f3f;
        }
        footer {
            background-color: #001f3f;
            color: white;
            padding: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
    <!-- Include navigation bar -->
    <?php include('navbar.php'); ?>

    <main class="container">
        <div class="profile-container">
            <h2 class="text-center mb-4"><i class="fas fa-user me-2"></i>Profile</h2>

            <!-- Display success or error messages -->
            <?php if ($success): ?>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i><?php echo $_SESSION['success_message']; unset($_SESSION['success_message']); ?>
                </div>
            <?php endif; ?>

            <?php if (!empty($errors)): ?>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <strong><i class="fas fa-exclamation-triangle me-2"></i>Error(s):</strong>
                    <ul>
                        <?php foreach ($errors as $error): ?>
                            <li><?php echo htmlspecialchars($error); ?></li>
                        <?php endforeach; ?>
                    </ul>
                </div>
            <?php endif; ?>

            <div class="form-container">
                <form method="POST" action="" novalidate>
             
                    <div class="row mb-4">
                        <div class="col-md-4 mb-3">
                            <label for="member_id" class="form-label">Member ID</label>
                            <input type="text" class="form-control" id="member_id" value="<?php echo htmlspecialchars($member['member_id']); ?>" readonly disabled>
                        </div> 
                        <div class="col-md-4 mb-3">
                            <label for="first_name" class="form-label">First Name</label>
                            <input type="text" class="form-control" id="first_name" name="first_name" value="<?php echo htmlspecialchars($member['first_name']); ?>" readonly disabled>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="last_name" class="form-label">Last Name</label>
                            <input type="text" class="form-control" id="last_name" name="last_name" value="<?php echo htmlspecialchars($member['last_name']); ?>" readonly disabled>
                        </div>                    
                    </div>

                    <div class="row mb-4">
                        <div class="col-md-6 mb-8">
                            <label for="member_id" class="form-label">Email</label>
                            <input type="text" class="form-control" id="email" name="email" value="<?php echo htmlspecialchars($member['email']); ?>" readonly disabled>
                        </div> 
                        <div class="col-md-6 mb-4">
                            <label for="first_name" class="form-label">Contact Number</label>
                            <input type="text" class="form-control" id="contact_num" name="contact_num" value="<?php echo htmlspecialchars($member['contact_num']); ?>" readonly disabled>
                        </div>                   
                    </div>

                    <a href="members.php" class="btn btn-navy">
                        <i class="fas fa-arrow-left me-2"></i>Back to Members
                    </a>
                </form>                
            </div>
        </div>
    </main>

    <!-- Include footer -->
    <?php include('footer.php'); ?>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JS for Form Validation -->
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const form = document.querySelector('form');
            form.addEventListener('submit', function (e) {
                if (!form.checkValidity()) {
                    e.preventDefault();
                    e.stopPropagation();
                }
                form.classList.add('was-validated');
            });
        });
        document.addEventListener("DOMContentLoaded", function() {
            setTimeout(function() {
                let alertBox = document.querySelector(".alert");
                if (alertBox) {
                    alertBox.style.transition = "opacity 0.5s";
                    alertBox.style.opacity = "0";
                    setTimeout(() => alertBox.style.display = "none", 500);
                }
            }, 2000); // 2 seconds delay
        });
    </script>
</body>
</html>
