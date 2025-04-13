<?php
require_once('database.php');
require_once('functions.php');

// Start session
session_start();

$login_errors = [];

// Handle login form submission
if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST['login'])) {
    $username = sanitize_input($_POST['username'] ?? '');
    $password = sanitize_input($_POST['password'] ?? '');

    // Save username in a cookie for convenience (30 days expiration)
    setcookie("last_username", $username, time() + (86400 * 30), "/");

    // Validate inputs  
    if (empty($username)) {
        $login_errors[] = "Username or ID is required.";
    }
    if (empty($password)) {
        $login_errors[] = "Password is required.";
    }

    // If no errors, proceed with authentication
    if (empty($login_errors)) {
        $stmt = $conn->prepare("
            SELECT o.officer_id, o.username, o.password, m.member_id, r.role_id 
            FROM officers o
            LEFT JOIN members m ON o.member_id = m.member_id
            LEFT JOIN role r ON o.role_id = r.role_id
            WHERE o.username = ? OR o.officer_id = ? OR m.member_id = ? OR r.role_id = ?
          ");
        $stmt->bind_param("ssss", $username, $username, $username, $username);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
          $user = $result->fetch_assoc();
      
          if (password_verify($password, $user['password'])) {
              // Successful login—store session variables
              $_SESSION['officer_id'] = $user['officer_id'];
              $_SESSION['username'] = $user['username'];
              $_SESSION['role_id'] = $user['role_id'];
              $_SESSION['member_id'] = $user['member_id'];
      
              log_activity('Login', "User logged in successfully", $user['officer_id']);
              header("Location: index.php");
              exit();
          } else {
              $login_errors[] = "Incorrect password.";
          }
        } else {
            $login_errors[] = "Username not found.";
        }

        $stmt->close();
    }
}

// Retrieve last username from cookie if available
$last_username = $_COOKIE['last_username'] ?? '';
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Officer Login</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="icon" href="images/info-tech.svg">
    
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

        .alert-danger {
          padding: 10px;
        }

        .input-group-text {
            cursor: pointer;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="bg-navy text-white text-center py-3">
        <h1>INTEL Membership Records</h1>
    </header>

    <!-- Main Content -->
    <main class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header text-center bg-navy text-white">
                        <h4>Login</h4>
                    </div>
                    <div class="card-body">
                        <!-- Display login error messages -->
                        <?php if (!empty($login_errors)): ?>
                            <div class="alert alert-danger alert-dismissible" role="alert">
                                <ul class="mb-0">
                                    <?php foreach ($login_errors as $error): ?>
                                        <li><?php echo htmlspecialchars($error); ?></li>
                                    <?php endforeach; ?>
                                </ul>
                            </div>
                        <?php endif; ?>

                        <!-- Login Form -->
                        <form action="login.php" method="POST">
                            <div class="mb-3">
                                <label for="username" class="form-label">ID or Username</label>
                                <input type="text" class="form-control" id="username" name="username" value="<?php echo htmlspecialchars($last_username); ?>" required>
                            </div>

                            <div class="mb-3">
                                <label for="password" class="form-label">Password</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="password" name="password" required>
                                    <span class="input-group-text" id="togglePassword">
                                        <i class="fas fa-eye"></i>
                                    </span>
                                </div>
                            </div>

                            <button type="submit" class="btn btn-navy w-100 text-white" name="login">Login</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <?php include 'footer.php'; ?>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Password Toggle Script -->
    <script>
        const passwordField = document.getElementById("password");
        const togglePassword = document.getElementById("togglePassword");

        togglePassword.addEventListener("click", () => {
            if (passwordField.type === "password") {
                passwordField.type = "text";
                togglePassword.innerHTML = '<i class="fas fa-eye-slash"></i>'; // Change icon
            } else {
                passwordField.type = "password";
                togglePassword.innerHTML = '<i class="fas fa-eye"></i>'; // Change icon
            }
        });
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