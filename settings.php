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

// Handle form submission
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $username = sanitize_input($_POST['username'] ?? '');
    $email = sanitize_input($_POST['email'] ?? '');
    $password = sanitize_input($_POST['password'] ?? '');
    $confirm_password = sanitize_input($_POST['confirm_password'] ?? '');

    // Validate inputs
    if (empty($username)) {
        $errors[] = "Username is required.";
    }

    if (empty($email)) {
        $errors[] = "Email is required.";
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $errors[] = "Invalid email format.";
    }

    if (!empty($password)) {
        if ($password !== $confirm_password) {
            $errors[] = "Passwords do not match.";
        } elseif (strlen($password) < 8) {
            $errors[] = "Password must be at least 8 characters long.";
        }
    }

    // If no errors, update data
    if (empty($errors)) {
        try {
            if (!empty($password)) {
                $password_hash = password_hash($password, PASSWORD_DEFAULT);
                $stmt = $conn->prepare("UPDATE officers SET username = ?, password = ? WHERE officer_id = ?");
                $stmt->bind_param("ssss", $username, $password_hash, $user_id);
            } else {
                $stmt = $conn->prepare("UPDATE officers SET username = ?, email = ? WHERE officer_id = ?");
                $stmt->bind_param("sss", $username, $email, $user_id);
            }

            if ($stmt->execute()) {
                $success = true;
                log_activity('Update Settings', "User updated their settings: $username", $user_id);
                $_SESSION['success_message'] = "Settings updated successfully!";
                header("Location: settings.php");
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
    <title>Settings | INTEL</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .settings-container {
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
    </style>
</head>
<body>
    <!-- Include navigation bar -->
    <?php include('navbar.php'); ?>

    <main class="container mt-5 mb-5">
        <div class="settings-container">
            <h2 class="text-center mb-4"><i class="fas fa-cogs me-2"></i>Account Settings</h2>

            <!-- Display success or error messages -->
            <?php if ($success): ?>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i><?php echo $_SESSION['success_message']; unset($_SESSION['success_message']); ?>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
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
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <?php endif; ?>

            <form method="POST" action="" novalidate>
            <div class="row md-4">
                <div class="col-md-4 mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" name="username" value="<?php echo htmlspecialchars($user['username']); ?>" required>
                    <div class="invalid-feedback">Username is required.</div>
                </div>
                <div class="col-md-4 mb-3">
                    <label for="password" class="form-label">New Password</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="password" name="password">
                        <span class="input-group-text" id="togglePassword">
                            <i class="fas fa-eye"></i>
                        </span>
                    </div>
                    <div class="invalid-feedback">Password must be at least 8 characters long.</div>
                </div>

                <div class="col-md-4 mb-3">
                    <label for="confirm_password" class="form-label">Confirm Password</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="confirm_password" name="confirm_password">
                        <span class="input-group-text" id="toggleConfirmPassword">
                            <i class="fas fa-eye"></i>
                        </span>
                    </div>
                    <div class="invalid-feedback">Passwords do not match.</div>
                </div>
            </div>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save me-1"></i> Save Changes
                </button>
            </form>
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

        setupPasswordToggle("password", "togglePassword");
        setupPasswordToggle("confirm_password", "toggleConfirmPassword");
    </script>
</body>
</html>
