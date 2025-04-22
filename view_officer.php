<?php
    // Start session
    session_start();
    $current_officer_id = $_SESSION['officer_id'] ?? null;

    if (!$current_officer_id) {
        header("Location: login.php");
        exit();
    }

    $current_role = $_SESSION['officer_role'] ?? 'intel_member';

    // Include database connection
    require_once('database.php');
    require_once('functions.php');

    // Check if user is president (for edit/delete access)
    $is_officer = in_array($current_role, ['intel_president', 'intel_secretary']);

    // Check if ID is provided
    if (!isset($_GET['id'])) {
        header('Location: officers_list.php');
        exit();
    }

    $officer_id = $_GET['id'];

    // Fetch officer details with member and role information
    $stmt = $conn->prepare("
        SELECT o.officer_id, o.member_id, o.role_id, o.username, 
               m.first_name, m.last_name, m.email, m.contact_num,
               r.role_name
        FROM officers o
        JOIN members m ON o.member_id = m.member_id
        JOIN role r ON o.role_id = r.role_id
        WHERE o.officer_id = ?
    ");
    
    $stmt->bind_param("s", $officer_id);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows == 0) {
        // Officer not found, redirect to list
        header('Location: officers_list.php');
        exit();
    }

    $officer = $result->fetch_assoc();
    $stmt->close();

    // Get officer's activity history (optional - if you track this)
    $activity_query = "
        SELECT action, description, date
        FROM activity_logs 
        WHERE officer_id = ? 
        ORDER BY date DESC 
        LIMIT 4
    ";
    
    $has_activities = false;
    $activities = [];
    
    // Only execute if the officer_activities table exists
    try {
        $stmt = $conn->prepare($activity_query);
        $stmt->bind_param("s", $officer_id);
        $stmt->execute();
        $activity_result = $stmt->get_result();
        
        if ($activity_result && $activity_result->num_rows > 0) {
            $has_activities = true;
            while ($row = $activity_result->fetch_assoc()) {
                $activities[] = $row;
            }
        }
        $stmt->close();
    } catch (Exception $e) {
        // Table doesn't exist or other error - just continue without activities
    }
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Officer Details | INTEL</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
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
        .navbar {
            background-color: #001f3f !important;
        }
        .btn-primary {
            background-color: #001f3f;
            border-color: #001f3f;
        }
        .btn-primary:hover {
            background-color: #003366;
            border-color: #003366;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .profile-header {
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 15px 15px 0 0;
            border-bottom: 1px solid #dee2e6;
        }
        .profile-body {
            padding: 20px;
        }
        .info-label {
            font-weight: 600;
            color: #495057;
        }
        .activity-item {
            padding: 15px;
            border-bottom: 1px solid #dee2e6;
        }
        .activity-item:last-child {
            border-bottom: none;
        }
        .activity-date {
            font-size: 0.85rem;
            color: #6c757d;
        }
        .action-buttons {
            display: flex;
            gap: 10px;
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
    <!-- Include navbar -->
    <?php include('navbar.php'); ?>

    <div class="container mt-4">

        <div class="row">
            <div class="col-md-8">
                <!-- Officer Information Card -->
                <div class="card">
                    <div class="profile-header">
                        <div class="d-flex align-items-center">
                            <div>
                                <h3><?php echo htmlspecialchars($officer['first_name'] . ' ' . $officer['last_name']); ?></h3>
                                <p class="mb-1"><?php echo htmlspecialchars($officer['role_name']); ?></p>
                                <span class="badge bg-primary">Officer ID: <?php echo htmlspecialchars($officer['officer_id']); ?></span>
                            </div>
                        </div>
                    </div>
                    <div class="profile-body">
                        <div class="row mb-3">
                            <div class="col-md-4">
                                <p class="info-label">Student ID</p>
                                <p><?php echo htmlspecialchars($officer['member_id']); ?></p>
                            </div>
                            <div class="col-md-4">
                                <p class="info-label">Username</p>
                                <p><?php echo htmlspecialchars($officer['username']); ?></p>
                            </div>
                            <div class="col-md-4">
                                <p class="info-label">Role</p>
                                <p><?php echo htmlspecialchars($officer['role_name']); ?></p>
                            </div>
                        </div>
                        
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <p class="info-label">Email</p>
                                <p><?php echo htmlspecialchars($officer['email'] ?? 'N/A'); ?></p>
                            </div>
                            <div class="col-md-6">
                                <p class="info-label">Contact Number</p>
                                <p><?php echo htmlspecialchars($officer['contact_num'] ?? 'N/A'); ?></p>
                            </div>
                        </div>
                        
                        <div class="action-buttons">
                            <a href="officer_list.php" class="btn btn-secondary">
                                <i class="fas fa-arrow-left me-2"></i> Back to List
                            </a>
                            <?php if ($is_officer): ?>
                            <a href="edit_officer.php?id=<?php echo htmlspecialchars($officer['officer_id']); ?>" class="btn btn-warning">
                                <i class="fas fa-edit me-2"></i> Edit
                            </a>
                            <button onclick="confirmDelete('<?php echo htmlspecialchars($officer['officer_id']); ?>')" class="btn btn-danger">
                                <i class="fas fa-trash me-2"></i> Delete
                            </button>
                            <?php endif; ?>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <!-- Officer Activities Card (Optional) -->
                <?php if ($is_officer): ?>
                <div class="card">
                    <div class="card-header bg-white">
                        <h5 class="card-title mb-0">Recent Activities</h5>
                    </div>
                    <div class="card-body p-0">
                        <?php if ($has_activities): ?>
                            <ul class="list-unstyled m-0">
                                <?php foreach ($activities as $activity): ?>
                                    <li class="activity-item">
                                        <div class="d-flex justify-content-between">
                                            <strong><?php echo htmlspecialchars($activity['action']); ?></strong>
                                            <span class="activity-date"><?php echo date('M d, Y', strtotime($activity['date'])); ?></span>
                                        </div>
                                        <p class="mb-0 mt-1"><?php echo htmlspecialchars($activity['description']); ?></p>
                                    </li>
                                <?php endforeach; ?>
                            </ul>
                        <?php else: ?>
                            <div class="p-4 text-center">
                                <i class="fas fa-history fa-3x mb-3 text-muted"></i>
                                <p>No recent activities found.</p>
                            </div>
                        <?php endif; ?>
                    </div>
                </div>
                <?php endif; ?>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <?php include('footer.php'); ?>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Confirmation script for delete operation -->
    <script>
        function confirmDelete(id) {
            if (confirm("Are you sure you want to delete this officer?")) {
                window.location.href = "officer_list.php?action=delete&id=" + id;
            }
        }
    </script>
</body>
</html>