<?php
    // Start session
    session_start();
    $officer_id = $_SESSION['officer_id'] ?? null;

    if (!$officer_id) {
        header("Location: login.php");
        exit();
    }

    $current_role = $_SESSION['officer_role'] ?? 'intel_member';

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
        $_SESSION['name'] = $row['first_name'] . ' ' . $row['last_name']; // Store name for display
    } else {
        $_SESSION['officer_role'] = 'intel_member';  // Default role if not found
        $_SESSION['role_id'] = 'intel_member';       // Match the keys
    }

    $stmt->close();

    // Check if user is president (for edit/delete access)
    $is_officer = in_array($current_role, ['intel_president', 'intel_secretary']);

    // Handle delete operation - only allow for president
    if ($is_officer && isset($_GET['action']) && $_GET['action'] == 'delete' && isset($_GET['id'])) {
        $officer_id = $_GET['id'];
        $delete_query = "DELETE FROM officers WHERE officer_id = ?";
        $stmt = $conn->prepare($delete_query);
        $stmt->bind_param("s", $officer_id);
        
        if ($stmt->execute()) {
            // Fetch officer details before deletion for the log
            $officer_details = "Officer ID: $officer_id";
            log_activity('Delete Officer', "Officer deleted: $officer_details", $_SESSION['officer_id']);
            $_SESSION['success_message'] = "Officer deleted successfully.";
        } else {
            $error_message = "Error deleting officer: " . $conn->error;
        }
        $stmt->close();
    }

    // Fetch all officers from the database with member names and role names
    $query = "SELECT o.member_id, o.role_id, 
                     m.first_name, m.last_name,
                     r.role_name 
              FROM officers o 
              JOIN members m ON o.member_id = m.member_id 
              JOIN role r ON o.role_id = r.role_id 
              ORDER BY o.role_id";
    $result = $conn->query($query);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Meta and Title -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Officers | INTEL</title>
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
            background-color: #001f3f;
            border-color: #001f3f;
            color: #fff;
        }
        .btn-navy:hover {
            background-color: #003366;
            border-color: #003366;
            color: #fff;
        }
        .table-container {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            padding: 20px;
        }
        .action-buttons .btn {
            width: 36px;
            height: 36px;
            padding: 6px 0;
            border-radius: 50%;
            text-align: center;
            margin: 0 3px;
        }
        .pagination .page-item.active .page-link {
            background-color: #001f3f;
            border-color: #001f3f;
        }
        .no-results {
            text-align: center;
            padding: 40px 0;
        }
        .no-results i {
            font-size: 4rem;
            color: #adb5bd;
        }
        .role-badge {
            border-radius: 20px;
            padding: 5px 12px;
            font-size: 0.85rem;
        }
        .role-president {
            background-color: #cce5ff;
            color: #004085;
        }
        .role-treasurer {
            background-color: #d4edda;
            color: #155724;
        }
        .role-secretary {
            background-color: #fff3cd;
            color: #856404;
        }
        .role-vicepresident {
            background-color: #d1ecf1;
            color: #0c5460;
        }
        .role-default {
            background-color: #e2e3e5;
            color: #383d41;
        }
        .footer {
            background-color: #001f3f !important;
            color: white;
            text-align: center;
            padding: 10px 0;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <?php include('navbar.php'); ?>

    <!-- Main Content -->
    <main class="container my-5">
        <!-- Success Message Display -->
        <?php if(isset($_SESSION['success_message'])): ?>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i><?php echo $_SESSION['success_message']; ?>
                <?php unset($_SESSION['success_message']); ?>                
            </div>
        <?php endif; ?>
        <?php if (!empty($_SESSION['warning_message'])): ?>
            <div class="alert alert-warning">
                <i class="fas fa-exclamation-circle"></i>
                <?php echo $_SESSION['warning_message']; ?>
                <?php unset($_SESSION['warning_message']); ?>
            </div>
        <?php endif; ?>

        <div class="row align-items-center mb-4">
            <?php if ($is_officer): ?>
            <div class="col-md-6">
                <a href="new_officer.php" class="btn btn-navy">
                    <i class="fas fa-user-plus me-2"></i>Add New Officer
                </a>
            </div>
            <?php endif; ?>
            
            <div class="col-md-6 mt-md-0 mt-3">
                <form class="d-flex" method="GET" action="">
                    <input type="text" class="form-control me-2" id="searchBar" placeholder="Search officers..." name="search" value="<?php echo isset($search) ? htmlspecialchars($search) : ''; ?>">
                    <button type="submit" class="btn btn-navy">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
            </div>
        </div>

        <!-- Officers Table -->
        <div class="table-container mt-4">
            <?php if(isset($result) && $result && $result->num_rows > 0): ?>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>Student ID</th>
                                <th>Name</th>
                                <th>Role</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody id="officersTableBody">
                            <?php while($row = $result->fetch_assoc()): ?>
                                <?php 
                                    // Generate a safe modal ID
                                    $modal_id = 'delete_' . preg_replace('/[^a-zA-Z0-9]/', '_', $row['officer_id']);
                                ?>
                                <tr>
                                    <td><?php echo htmlspecialchars($row['member_id']); ?></td>
                                    <td><?php echo htmlspecialchars($row['first_name'] . ' ' . $row['last_name']); ?></td>
                                    <td><?php echo htmlspecialchars($row['role_name']); ?></td>
                                    <td>
                                        <div class="action-buttons d-flex justify-content-center">
                                            <a href="view_officer.php?id=<?php echo htmlspecialchars($row['officer_id']); ?>" 
                                               class="btn btn-info text-white" title="View Details">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            
                                            <?php if ($is_officer): ?>
                                            <a href="edit_officer.php?id=<?php echo htmlspecialchars($row['officer_id']); ?>" 
                                               class="btn btn-warning text-white" title="Edit">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            
                                            <button type="button" class="btn btn-danger" data-bs-toggle="modal" 
                                                    data-bs-target="#<?php echo $modal_id; ?>" title="Delete">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                            <?php endif; ?>
                                        </div>
                                        
                                        <?php if ($is_officer): ?>
                                        <!-- Delete Confirmation Modal -->
                                        <div class="modal fade" id="<?php echo $modal_id; ?>" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header bg-danger text-white">
                                                        <h5 class="modal-title" id="deleteModalLabel">Confirm Deletion</h5>
                                                    </div>
                                                    <div class="modal-body">
                                                        <p>Are you sure you want to delete officer <strong><?php echo htmlspecialchars($row['first_name'] . ' ' . $row['last_name']); ?></strong>?</p>
                                                        <p class="text-danger"><small>This action cannot be undone.</small></p>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                        <a href="officer_list.php?action=delete&id=<?php echo htmlspecialchars($row['officer_id']); ?>" class="btn btn-danger">Delete</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <?php endif; ?>
                                    </td>
                                </tr>
                            <?php endwhile; ?>
                        </tbody>
                    </table>
                </div>
                
                <!-- Pagination -->
                <?php if(isset($total_pages) && $total_pages > 1): ?>
                    <div class="d-flex justify-content-between align-items-center mt-4">
                        <div>
                            <p class="text-muted">Showing <?php echo min($offset + 1, $total_records); ?> to <?php echo min($offset + $records_per_page, $total_records); ?> of <?php echo $total_records; ?> officers</p>
                        </div>
                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <!-- Previous Button -->
                                <li class="page-item <?php echo ($page <= 1) ? 'disabled' : ''; ?>">
                                    <a class="page-link" href="?page=<?php echo $page - 1; ?><?php echo isset($search) && !empty($search) ? '&search=' . urlencode($search) : ''; ?><?php echo isset($role_filter) && !empty($role_filter) ? '&role=' . urlencode($role_filter) : ''; ?>" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                
                                <!-- Page Numbers -->
                                <?php for($i = max(1, $page - 2); $i <= min($page + 2, $total_pages); $i++): ?>
                                    <li class="page-item <?php echo ($page == $i) ? 'active' : ''; ?>">
                                        <a class="page-link" href="?page=<?php echo $i; ?><?php echo isset($search) && !empty($search) ? '&search=' . urlencode($search) : ''; ?><?php echo isset($role_filter) && !empty($role_filter) ? '&role=' . urlencode($role_filter) : ''; ?>">
                                            <?php echo $i; ?>
                                        </a>
                                    </li>
                                <?php endfor; ?>
                                
                                <!-- Next Button -->
                                <li class="page-item <?php echo ($page >= $total_pages) ? 'disabled' : ''; ?>">
                                    <a class="page-link" href="?page=<?php echo $page + 1; ?><?php echo isset($search) && !empty($search) ? '&search=' . urlencode($search) : ''; ?><?php echo isset($role_filter) && !empty($role_filter) ? '&role=' . urlencode($role_filter) : ''; ?>" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                <?php endif; ?>
            <?php else: ?>
                <!-- No Results Found -->
                <div class="no-results">
                    <i class="fas fa-search"></i>
                    <h3>No officers found</h3>
                    <p class="text-muted">
                        <?php if(isset($search) && !empty($search) || isset($role_filter) && !empty($role_filter)): ?>
                            Try adjusting your search criteria or filters.
                        <?php else: ?>
                            No officers have been added yet. Click the "Add New Officer" button to get started.
                        <?php endif; ?>
                    </p>
                    <?php if(isset($search) && !empty($search) || isset($role_filter) && !empty($role_filter)): ?>
                        <a href="officer_list.php" class="btn btn-secondary mt-3">
                            <i class="fas fa-sync-alt"></i> Reset All Filters
                        </a>
                    <?php endif; ?>
                </div>
            <?php endif; ?>
        </div>
    </main>

    <!-- Footer -->
    <?php include('footer.php'); ?>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function(){
            $("#searchBar").on("keyup", function() {
                var query = $(this).val();
                $.ajax({
                    url: "fetch_officers.php",
                    method: "GET",
                    data: { search: query },
                    success: function(response) {
                        $("#officersTableBody").html(response);
                    },
                    error: function(xhr, status, error) {
                        console.error("AJAX Error: " + error);
                    }
                });
            });
        });
        
        document.addEventListener("DOMContentLoaded", function() {
            setTimeout(function() {
                let alertBoxes = document.querySelectorAll(".alert");
                
                alertBoxes.forEach(alertBox => {
                    alertBox.style.transition = "opacity 0.5s";
                    alertBox.style.opacity = "0";
                    setTimeout(() => alertBox.style.display = "none", 500);
                });
            }, 2500);
        });
    </script>
</body>
</html>