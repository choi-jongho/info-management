<?php
    // Start session
    session_start();

    // Check if officer is logged in
    $officer_id = $_SESSION['officer_id'] ?? null;
    if (!$officer_id) {
        header("Location: login.php");
        exit();
    }

    // Include database connection
    require_once('database.php');

    // Fetch officer role dynamically from database
    $stmt = $conn->prepare("
        SELECT r.role_id 
        FROM officers o 
        JOIN role r ON o.role_id = r.role_id 
        WHERE o.officer_id = ?
    ");
    $stmt->bind_param("s", $officer_id);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $_SESSION['officer_role'] = $row['role_id'];  // Store role in session
    } else {
        $_SESSION['officer_role'] = 'intel_member';  // Default role
    }

    $stmt->close();

    // Check database connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Fetch member statistics securely
    $stats = [];

    // Total members
    $stmt = $conn->prepare("SELECT COUNT(*) AS total FROM members");
    $stmt->execute();
    $result = $stmt->get_result();
    $stats['total_members'] = $result->fetch_assoc()['total'];

    // Active members
    $stmt = $conn->prepare("SELECT COUNT(*) AS active FROM members WHERE status = 'Active'");
    $stmt->execute();
    $result = $stmt->get_result();
    $stats['active_members'] = $result->fetch_assoc()['active'];

    // Inactive members
    $stmt = $conn->prepare("SELECT COUNT(*) AS inactive FROM members WHERE status = 'Inactive'");
    $stmt->execute();
    $result = $stmt->get_result();
    $stats['inactive_members'] = $result->fetch_assoc()['inactive'];

    // Recent members (last 4 added)
    $stmt = $conn->prepare("
        SELECT member_id, first_name, last_name, status 
        FROM members 
        ORDER BY membership_date DESC 
        LIMIT 4
    ");
    $stmt->execute();
    $recent_members = $stmt->get_result();

    // Close statement
    $stmt->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Meta and Title -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | INTEL</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="icon" href="images/info-tech.png">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
            background-color: #001f3f;
            border-color: #001f3f;
            color: #fff;
        }
        .btn-navy:hover {
            background-color: #003366;
            border-color: #003366;
            color: #fff;
        }
        .dashboard-container {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            padding: 20px;
            margin-bottom: 20px;
        }
        .stat-card {
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        .stat-card:hover {
            transform: translateY(-5px);
        }
        .stat-card i {
            font-size: 2.5rem;
            margin-bottom: 15px;
        }
        .stat-card h3 {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 5px;
        }
        .stat-card p {
            color: #6c757d;
            margin-bottom: 0;
        }
        .bg-light-blue {
            background-color: #e3f2fd;
            color: #0d6efd;
        }
        .bg-light-green {
            background-color: #e8f5e9;
            color: #2e7d32;
        }
        .bg-light-danger {
            background-color: #ffebee;
            color: #f44336;
        }
        .bg-light-purple {
            background-color: #f3e5f5;
            color: #9c27b0;
        }
        .recent-table th, .recent-table td {
            padding: 12px 15px;
            vertical-align: middle;
        }
        .status-badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.8rem;
        }
        .status-active {
            background-color: #d4edda;
            color: #155724;
        }
        .status-inactive {
            background-color: #f8d7da;
            color: #721c24;
        }
        .chart-container {
            position: relative;
            height: 250px;
            width: 100%;
        }
        .welcome-banner {
            background: linear-gradient(135deg, #001f3f 0%, #0074d9 100%);
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 25px;
            color: white;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .welcome-banner h2 {
            font-weight: 700;
            margin-bottom: 10px;
        }
        .welcome-banner p {
            margin-bottom: 0;
            opacity: 0.9;
        }
        .action-btn {
            padding: 8px 15px;
            border-radius: 50px;
            font-weight: 500;
            font-size: 0.9rem;
            margin-right: 5px;
        }
    </style>
</head>
<body>
    <!--Header-->
    <?php include('navbar.php'); ?>

    <!-- Main Content -->
    <main class="container my-4">
        <!-- Success/Error Messages -->
        <?php if(isset($_SESSION['success_message'])): ?>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <?php 
                    echo $_SESSION['success_message']; 
                    unset($_SESSION['success_message']);
                ?>
            </div>
        <?php endif; ?>

        <?php if(isset($_SESSION['error_message'])): ?>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <?php 
                    echo $_SESSION['error_message']; 
                    unset($_SESSION['error_message']);
                ?>
            </div>
        <?php endif; ?>

        <!-- Welcome Banner -->
        <div class="welcome-banner">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <h2>Welcome to INTEL Membership Records</h2>
                    <p>View member statistics, manage records, and track balances all in one place.</p>
                </div>
                <?php if (in_array($_SESSION['officer_role'], ['intel_treasurer', 'intel_president'])): ?>
                    <div class="col-lg-4 text-lg-end mt-3 mt-lg-0">
                        <a href="add_member.php" class="btn btn-light action-btn">
                            <i class="fas fa-user-plus me-1"></i>Add Member
                        </a>
                    </div>
                <?php endif; ?>
            </div>
        </div>

        <!-- Statistics Cards -->
        <div class="row">
            <div class="col-md-4">
                <div class="stat-card bg-light-blue text-center">
                    <i class="fas fa-user-check"></i>
                    <h3><?php echo number_format($stats['total_members']); ?></h3>
                    <p>All Members</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card bg-light-green text-center">
                    <i class="fas fa-user-check"></i>
                    <h3><?php echo number_format($stats['active_members']); ?></h3>
                    <p>Active Members</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card bg-light-danger text-center">
                    <i class="fas fa-user-xmark"></i>
                    <h3><?php echo number_format($stats['inactive_members']); ?></h3>
                    <p>Inactive Members</p>
                </div>
            </div>
        </div>

        <div class="row">
            <!-- Member Status Chart -->
            <div class="col-lg-6">
                <div class="dashboard-container h-100">
                    <h4 class="mb-4"><i class="fas fa-chart-pie me-2"></i>Member Status Distribution</h4>
                    <div class="chart-container">
                        <canvas id="statusChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Recent Members -->
            <div class="col-lg-6">
                <div class="dashboard-container h-100">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4 class="mb-0"><i class="fas fa-history me-2"></i>Recently Added Members</h4>
                        <a href="members.php" class="btn btn-sm btn-navy">View All</a>
                    </div>
                    
                    <div class="table-responsive">
                        <table class="table table-hover recent-table">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Member ID</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if($recent_members->num_rows > 0): ?>
                                    <?php while($member = $recent_members->fetch_assoc()): ?>
                                        <tr>
                                            <td><?php echo htmlspecialchars($member['first_name'] . ' ' . $member['last_name']); ?></td>
                                            <td><?php echo htmlspecialchars($member['member_id']); ?></td>
                                            <td>
                                                <?php
                                                    $status_class = '';
                                                    switch ($member['status']) {
                                                        case 'Active':
                                                            $status_class = 'status-active';
                                                            break;
                                                        case 'Inactive':
                                                            $status_class = 'status-inactive';
                                                            break;
                                                        default:
                                                            $status_class = '';
                                                    }
                                                ?>
                                                <span class="status-badge <?php echo $status_class; ?>">
                                                    <?php echo htmlspecialchars($member['status']); ?>
                                                </span>
                                            </td>
                                            <td>
                                                <a href="view_member.php?id=<?php echo $member['member_id']; ?>" class="btn btn-sm btn-primary" title="View">
                                                    <i class="fas fa-eye"></i>
                                                </a>

                                                <?php if (in_array($_SESSION['officer_role'], ['intel_treasurer', 'intel_president'])): ?>
                                                    <a href="edit_member.php?id=<?php echo $member['member_id']; ?>" class="btn btn-sm btn-warning text-white" title="Edit">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                <?php endif; ?>
                                            </td>
                                        </tr>
                                    <?php endwhile; ?>
                                <?php else: ?>
                                    <tr>
                                        <td colspan="4" class="text-center">No members found</td>
                                    </tr>
                                <?php endif; ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-navy text-white text-center py-3 mt-auto">
        <p class="mb-0">&copy; 2025 Information Technology Link | All Rights Reserved</p>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Chart Initialization -->
    <script>
        // Status distribution chart
        const statusCtx = document.getElementById('statusChart').getContext('2d');
        const statusChart = new Chart(statusCtx, {
            type: 'doughnut',
            data: {
                labels: ['Active', 'Inactive'],
                datasets: [{
                    data: [
                        <?php echo $stats['active_members']; ?>, 
                        <?php echo $stats['inactive_members']; ?>, 
                    ],
                    backgroundColor: [
                        '#4CAF50',  // green for active
                        '#F44336',  // red for inactive
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
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