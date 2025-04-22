<?php
    // Start session
    session_start();
    $officer_id = $_SESSION['officer_id'] ?? null;

    if (!$officer_id) {
        header("Location: login.php");
        exit();
    }

    // Include database connection (only once)
    require_once('database.php');
    require_once('functions.php');

    // Fetch officer's role dynamically
    $stmt = $conn->prepare("
        SELECT r.role_id, r.role_name, m.first_name, m.last_name 
        FROM officers o 
        JOIN members m ON o.member_id = m.member_id 
        JOIN role r ON o.role_id = r.role_id 
        WHERE o.officer_id = ?
    ");
    $stmt->bind_param("s", $officer_id);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $_SESSION['officer_role'] = $row['role_id'];  // Store role ID in session
        $_SESSION['role_id'] = $row['role_id'];      // Also store as role_id for consistency
        $_SESSION['role_name'] = $row['role_name'];  // Store role name too
        $_SESSION['name'] = $row['first_name'] . ' ' . $row['last_name']; // Store role name for display
    } else {
        $_SESSION['officer_role'] = 'intel_member';  // Default role if not found
        $_SESSION['role_id'] = 'intel_member';       // Match the keys
    }

    $stmt->close();

    // Check if ID is provided
    if (!isset($_GET['id'])) {
        header('Location: officer_list.php');
        exit();
    }

    $officer_id = $_GET['id'];

    // Process form submission
    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        $member_id = $_POST['member_id'];
        $role_id = $_POST['role_id'];
        $username = $_POST['username'];
        
        // Check if password should be updated
        if (!empty($_POST['password'])) {
            // Hash the password before storing
            $password = password_hash($_POST['password'], PASSWORD_DEFAULT);
            $update_query = "UPDATE officers SET member_id = ?, role_id = ?, username = ?, password = ? WHERE officer_id = ?";
            $stmt = $conn->prepare($update_query);
            $stmt->bind_param("sssss", $member_id, $role_id, $username, $password, $officer_id);
        } else {
            // Update without changing password
            $update_query = "UPDATE officers SET member_id = ?, role_id = ?, username = ? WHERE officer_id = ?";
            $stmt = $conn->prepare($update_query);
            $stmt->bind_param("ssss", $member_id, $role_id, $username, $officer_id);
        }
        
        if ($stmt->execute()) {
            $success_message = "Officer updated successfully!";
        } else {
            $error_message = "Error updating officer: " . $conn->error;
        }
        $stmt->close();
    }

    // Fetch current officer data
    $query = "SELECT officer_id, member_id, role_id, username FROM officers WHERE officer_id = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("s", $officer_id);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows == 0) {
        header('Location: officer_list.php');
        exit();
    }

    $officer = $result->fetch_assoc();
    $stmt->close();

    // Fetch all available members for dropdown
    $members_query = "SELECT member_id, CONCAT(member_id, ' - ', last_name, ', ', first_name) AS member_name FROM members ORDER BY last_name";
    $members_result = $conn->query($members_query);

    // Fetch all available roles for dropdown
    $roles_query = "SELECT role_id, role_name FROM role ORDER BY role_name";
    $roles_result = $conn->query($roles_query);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Officer | INTEL</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Selectize CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.15.2/css/selectize.bootstrap5.min.css">
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
        .navbar {
            background-color: #0a2351 !important;
        }
        .btn-primary {
            background-color: #0a2351;
            border-color: #0a2351;
        }
        .btn-primary:hover {
            background-color: #0d3168;
            border-color: #0d3168;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .card-header {
            background-color: #0a2351 !important;
            color: white !important;
        }
        /* Custom styles for selectize */
        .selectize-input {
            padding: 0.375rem 0.75rem;
            font-size: 1rem;
            border-radius: 0.25rem;
        }
        .bg-navy {
            background-color: #001f3f !important;
        }
        .text-white {
            color: #ffffff !important;
        }
    </style>
</head>
<body>
    <!-- Assume navbar is already included -->
    <?php include('navbar.php'); ?>

    <div class="container mt-4 mb-4">
        <div class="card">
            <div class="card-header bg-white">
                <h3 class="card-title"> <i class="fas fa-user-edit mt-2"></i> Edit Officer</h3>
            </div>
            <div class="card-body">
                <?php if(isset($success_message)): ?>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <?php echo $success_message; ?>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <?php endif; ?>
                
                <?php if(isset($error_message)): ?>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <?php echo $error_message; ?>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <?php endif; ?>

                <form method="post" action="">
                    <div class="mb-3">
                        <label for="officer_id" class="form-label">Officer ID</label>
                        <input type="text" class="form-control" id="officer_id" value="<?php echo htmlspecialchars($officer['officer_id']); ?>" readonly>
                    </div>
                    
                    <div class="mb-3">
                        <label for="member_id" class="form-label">Member</label>
                        <select class="form-select" id="member_id" name="member_id" required>
                            <option value="">Select Member</option>
                            <?php 
                            $members_array = [];
                            while($member = $members_result->fetch_assoc()): 
                                $members_array[] = $member;
                                $selected = ($member['member_id'] == $officer['member_id']) ? 'selected' : '';
                            ?>
                                <option value="<?php echo $member['member_id']; ?>" <?php echo $selected; ?>>
                                    <?php echo htmlspecialchars($member['member_name']); ?>
                                </option>
                            <?php endwhile; ?>
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label for="role_id" class="form-label">Role</label>
                        <select class="form-select" id="role_id" name="role_id" required>
                            <option value="">Select Role</option>
                            <?php 
                            $roles_array = [];
                            while($role = $roles_result->fetch_assoc()): 
                                $roles_array[] = $role;
                                $selected = ($role['role_id'] == $officer['role_id']) ? 'selected' : '';
                            ?>
                                <option value="<?php echo $role['role_id']; ?>" <?php echo $selected; ?>>
                                    <?php echo htmlspecialchars($role['role_name']); ?>
                                </option>
                            <?php endwhile; ?>
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label for="username" class="form-label">Username</label>
                        <input type="text" class="form-control" id="username" name="username" value="<?php echo htmlspecialchars($officer['username']); ?>" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" class="form-control" id="password" name="password">
                        <div class="form-text">Leave blank to keep current password.</div>
                    </div>
                    
                    <div class="d-flex justify-content-between">
                        <a href="officer_list.php" class="btn btn-secondary">Cancel</a>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <?php include('footer.php'); ?>

    <!-- jQuery first, then Bootstrap JS Bundle with Popper -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Selectize JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.15.2/js/selectize.min.js"></script>
    
    <script>
        $(document).ready(function() {
            // Initialize selectize for member_id with the ability to create new options
            $('#member_id').selectize({
                create: true,
                createOnBlur: true,
                sortField: 'text',
                placeholder: 'Select or enter member ID'
            });

            // Initialize selectize for role_id with the ability to create new options
            $('#role_id').selectize({
                create: true,
                createOnBlur: true,
                sortField: 'text',
                placeholder: 'Select or enter role ID'
            });
        });
    </script>
</body>
</html>