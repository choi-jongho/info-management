<?php
  require_once('database.php');
  require_once('functions.php');

  // Start session
  session_start();

  // Check if officer is logged in
  $officer_id = $_SESSION['officer_id'] ?? null;
  if (!$officer_id) {
      // Officer not logged in, redirect to login page
      header("Location: login.php");
      exit();
  }

  $signup_errors = [];

  // Handle signup form submission
  if ($_SERVER["REQUEST_METHOD"] === "POST") {
      $signup_officer_id = sanitize_input($_POST['signup_officer_id'] ?? '');
      $signup_member_id = sanitize_input($_POST['signup_member_id'] ?? '');
      $signup_role_id = sanitize_input($_POST['signup_role_id'] ?? '');
      $signup_username = sanitize_input($_POST['signup_username'] ?? '');
      $signup_password = sanitize_input($_POST['signup_password'] ?? '');
      $confirm_password = sanitize_input($_POST['confirm_password'] ?? '');

      // Validate inputs
      if (empty($signup_officer_id)) {
          $signup_errors[] = "Officer ID is required.";
      }
      if (empty($signup_member_id)) {
          $signup_errors[] = "Member ID is required.";
      }
      if (empty($signup_role_id)) {
          $signup_errors[] = "Role ID is required.";
      }
      if (empty($signup_username)) {
          $signup_errors[] = "Username is required.";
      }
      if (empty($signup_password)) {
          $signup_errors[] = "Password is required.";
      }
      if ($signup_password !== $confirm_password) {
          $signup_errors[] = "Passwords do not match.";
      }

      // If no errors, proceed with registration
      if (empty($signup_errors)) {
          $hashed_password = password_hash($signup_password, PASSWORD_DEFAULT);
          $stmt = $conn->prepare("INSERT INTO officers (officer_id, member_id, role_id, username, password) VALUES (?, ?, ?, ?, ?)");
          $stmt->bind_param("sssss", $signup_officer_id, $signup_member_id, $signup_role_id, $signup_username, $hashed_password);

          if ($stmt->execute()) {
              // Log activity only after the officer is successfully registered
              log_activity('Sign Up', "New officer registered: $signup_username", $stmt->insert_id);
              header("Location: new_officer.php?success=1"); // Redirect to new_officer.php with success parameter
              exit();
          } else {
              $signup_errors[] = "Failed to register. Please try again.";
          }

          $stmt->close();
      }
  }
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Meta and Title -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Officer | INTEL</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="icon" href="images/info-tech.png">
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
            <h1><i class="fas fa-user-tie me-2"></i>Add New Officer</h1>
            <a href="members.php" class="btn btn-outline-light">
                <i class="fas fa-arrow-left me-2"></i>Back to Members
            </a>
        </div>
    </header>

    <!-- Main Content -->
    <main class="container my-5">
        <!-- Success Message Display -->
        <?php if (isset($_GET['success']) && $_GET['success'] == 1): ?>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <strong>Success!</strong> Officer has been added successfully.
            </div>
        <?php endif; ?>

        <!-- Error Messages Display -->
        <?php if(isset($signup_errors) && !empty($signup_errors)): ?>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <strong>Error!</strong>
                <ul class="mb-0">
                    <?php foreach($signup_errors as $error): ?>
                        <li><?php echo htmlspecialchars($error); ?></li>
                    <?php endforeach; ?>
                </ul>
            </div>
        <?php endif; ?>

        <div class="form-container">
            <form method="POST" action="" novalidate>
                <div class="row mb-4">
                    <div class="col-md-4 mb-3">
                        <label for="signup_officer_id" class="form-label required-field">Officer ID</label>
                        <input type="text" class="form-control" id="signup_officer_id" name="signup_officer_id" value="<?php echo isset($_POST['signup_officer_id']) ? htmlspecialchars($_POST['signup_officer_id']) : ''; ?>" required>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="signup_member_id" class="form-label required-field">Member ID</label>
                        <input type="text" class="form-control" id="signup_member_id" name="signup_member_id" value="<?php echo isset($_POST['signup_member_id']) ? htmlspecialchars($_POST['signup_member_id']) : ''; ?>" required>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="signup_role_id" class="form-label required-field">Role ID</label>
                        <input type="text" class="form-control" id="signup_role_id" name="signup_role_id" value="<?php echo isset($_POST['signup_role_id']) ? htmlspecialchars($_POST['signup_role_id']) : ''; ?>" required>
                    </div>
                </div>
                
                <div class="row mb-4">
                    <div class="col-md-4 mb-3">
                        <label for="signup_username" class="form-label required-field">Username</label>
                        <input type="text" class="form-control" id="signup_username" name="signup_username" value="<?php echo isset($_POST['signup_username']) ? htmlspecialchars($_POST['signup_username']) : ''; ?>" required>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="signup_password" class="form-label required-field">Password</label>
                        <div class="input-group">
                            <input type="password" class="form-control" id="signup_password" name="signup_password" required>
                            <span class="input-group-text" id="togglePassword">
                                <i class="fas fa-eye"></i>
                            </span>
                        </div>
                    </div>

                    <div class="col-md-4 mb-3">
                        <label for="confirm_password" class="form-label required-field">Confirm Password</label>
                        <div class="input-group">
                            <input type="password" class="form-control" id="confirm_password" name="confirm_password" required>
                            <span class="input-group-text" id="toggleConfirmPassword">
                                <i class="fas fa-eye"></i>
                            </span>
                        </div>
                    </div>                   
                  </div>

                <div class="d-flex justify-content-end mt-4">
                    <a href="members.php" class="btn btn-secondary me-2">
                        <i class="fas fa-times me-1"></i> Cancel
                    </a>
                    <button type="submit" class="btn btn-navy">
                        <i class="fas fa-user-plus me-1"></i> Add Officer
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
    function setupPasswordToggle(inputId, toggleId) {
        const passwordField = document.getElementById(inputId);
        const togglePassword = document.getElementById(toggleId);

        togglePassword.addEventListener("click", () => {
            if (passwordField.type === "password") {
                passwordField.type = "text";
                togglePassword.innerHTML = '<i class="fas fa-eye-slash"></i>'; // Change icon
            } else {
                passwordField.type = "password";
                togglePassword.innerHTML = '<i class="fas fa-eye"></i>'; // Change icon
            }
        });
    }
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

    setupPasswordToggle("signup_password", "togglePassword");
    setupPasswordToggle("confirm_password", "toggleConfirmPassword");
</script>
</body>
</html>
