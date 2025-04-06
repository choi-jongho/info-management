<?php
    // Start session
    session_start();
    $officer_id = $_SESSION['officer_id'] ?? null;

    if (!$officer_id) {
        header("Location: login.php");
        exit();
    }

    // Include database connection
    require_once('database.php');

    // Fetch officer's role dynamically
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
        $_SESSION['officer_role'] = 'intel_member';  // Default role if not found
    }

    $stmt->close();

    // Include database connection
    include('database.php');

    // Get search parameters
    $search = isset($_GET['search']) ? trim($_GET['search']) : '';
    $status_filter = isset($_GET['status']) ? trim($_GET['status']) : '';

    // Pagination parameters
    $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
    $records_per_page = 10;
    $offset = ($page - 1) * $records_per_page;

    // Build the base query with secure filtering
    $query = "SELECT m.*, 
            (SELECT COALESCE(SUM(f.fee_amount), 0) FROM fees f WHERE f.member_id = m.member_id) AS total_fee_amount, 
            (SELECT COALESCE(COUNT(f.semester), 0) FROM fees f WHERE f.member_id = m.member_id) AS semester_count 
            FROM members m 
            WHERE 1=1";

    $count_query = "SELECT COUNT(DISTINCT m.member_id) as total 
                    FROM members m 
                    LEFT JOIN fees f ON m.member_id = f.member_id 
                    WHERE 1=1";

    // Apply search filters with prepared statements
    if (!empty($search)) {
        $query .= " AND (m.member_id LIKE ? 
                        OR m.first_name LIKE ? 
                        OR m.last_name LIKE ? 
                        OR m.email LIKE ? 
                        OR m.contact_num LIKE ?)";
        $count_query .= " AND (m.member_id LIKE ? 
                            OR m.first_name LIKE ? 
                            OR m.last_name LIKE ? 
                            OR m.email LIKE ? 
                            OR m.contact_num LIKE ?)";
    }

    // Apply status filter
    if (!empty($status_filter)) {
        $query .= " AND m.status = ?";
        $count_query .= " AND m.status = ?";
    }

    // Group results properly before pagination
    $query .= " GROUP BY m.member_id, m.first_name, m.last_name, m.email, m.contact_num, m.status";
    $query .= " ORDER BY m.last_name ASC LIMIT ?, ?";

    // Prepare main query statement
    $stmt = $conn->prepare($query);
    if (!empty($search) && !empty($status_filter)) {
        $search_param = "%" . $search . "%";
        $stmt->bind_param("ssssssii", $search_param, $search_param, $search_param, $search_param, $search_param, $status_filter, $offset, $records_per_page);
    } elseif (!empty($search)) {
        $search_param = "%" . $search . "%";
        $stmt->bind_param("sssssii", $search_param, $search_param, $search_param, $search_param, $search_param, $offset, $records_per_page);
    } elseif (!empty($status_filter)) {
        $stmt->bind_param("sii", $status_filter, $offset, $records_per_page);
    } else {
        $stmt->bind_param("ii", $offset, $records_per_page);
    }

    $stmt->execute();
    $result = $stmt->get_result();

    // Prepare count query statement
    $count_stmt = $conn->prepare($count_query);
    if (!empty($search) && !empty($status_filter)) {
        $count_stmt->bind_param("ssssss", $search_param, $search_param, $search_param, $search_param, $search_param, $status_filter);
    } elseif (!empty($search)) {
        $count_stmt->bind_param("sssss", $search_param, $search_param, $search_param, $search_param, $search_param);
    } elseif (!empty($status_filter)) {
        $count_stmt->bind_param("s", $status_filter);
    }

    $count_stmt->execute();
    $count_result = $count_stmt->get_result();
    $row_count = $count_result->fetch_assoc();
    $total_records = $row_count['total'];
    $total_pages = ceil($total_records / $records_per_page);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Meta and Title -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Members | INTEL</title>
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
        .status-active {
            background-color: #d4edda;
            color: #155724;
            border-radius: 20px;
            padding: 5px 12px;
            font-size: 0.85rem;
        }
        .status-inactive {
            background-color: #f8d7da;
            color: #721c24;
            border-radius: 20px;
            padding: 5px 12px;
            font-size: 0.85rem;
        }
        .action-buttons .btn {
            width: 36px;
            height: 36px;
            padding: 6px 0;
            border-radius: 50%;
            text-align: center;
            margin: 0 3px;
        }
        .pagination {
            margin-bottom: 0;
        }
        .no-results {
            text-align: center;
            padding: 40px 0;
        }
        .no-results i {
            font-size: 4rem;
            color: #adb5bd;
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
            </div>
            <?php unset($_SESSION['success_message']); ?>
        <?php endif; ?>

        <div class="row align-items-center mb-4">
            <!-- If NOT President or Treasurer, align search bar with filters -->
            <?php if (!in_array($_SESSION['officer_role'], ['intel_president', 'intel_treasurer'])): ?>
                <div class="col-md-6">
                    <form class="d-flex justify-content-between" method="GET" action="">
                        <input type="text" id="searchBar" class="form-control me-2"  placeholder="Search members..." name="search" value="<?php echo htmlspecialchars($search); ?>">
                        <button type="submit" class="btn btn-navy">
                            <i class="fas fa-search"></i>
                        </button>
                    </form>
                </div>
            <?php else: ?>
                <!-- If President or Treasurer, keep buttons separate -->
                <div class="col-md-6 d-flex gap-2">
                    <a href="add_member.php" class="btn btn-navy">
                        <i class="fas fa-user-plus me-2"></i>Add New Member
                    </a>
                    <a href="add_fees.php" class="btn btn-navy">
                        <i class="fas fa-dollar-sign me-2"></i>Add Fees
                    </a>
                </div>
                
                <div class="col-md-6 mt-md-0 mt-3 search-bar">
                    <form class="d-flex" method="GET" action="">
                        <input type="text" class="form-control me-2" id="searchBar" placeholder="Search members..." name="search" value="<?php echo htmlspecialchars($search); ?>">
                        <button type="submit" class="btn btn-navy">
                            <i class="fas fa-search"></i>
                        </button>
                    </form>
                </div>
            <?php endif; ?>
        </div>

        <!-- Filters -->
        <div class="bg-light p-3 rounded mb-4">
            <form method="GET" action="" class="row g-3">
                <?php if (!empty($search)): ?>
                    <input type="hidden" name="search" value="<?php echo htmlspecialchars($search); ?>">
                <?php endif; ?>

                <div class="col-md-4">
                    <label for="status" class="form-label">Status</label>
                    <select class="form-select" id="status" name="status" onchange="this.form.submit()">
                        <option value="">All Statuses</option>
                        <option value="Active" <?php echo $status_filter == 'Active' ? 'selected' : ''; ?>>Active</option>
                        <option value="Inactive" <?php echo $status_filter == 'Inactive' ? 'selected' : ''; ?>>Inactive</option>
                    </select>
                </div>

                <div class="col-md-4 d-flex align-items-end">
                    <a href="members.php" class="btn btn-secondary w-100">
                        <i class="fas fa-sync-alt me-2"></i>Reset Filters
                    </a>
                </div>
            </form>
        </div>

        <!-- Members Table -->
        <div class="table-container">
            <?php if ($result->num_rows > 0): ?>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>Member ID</th>
                                <th>Name</th>
                                <th>Contact Info</th>
                                <th>Status</th>
                                <th>Balance</th>
                                <th>Semester</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody id="membersTableBody">
                            <?php while($row = $result->fetch_assoc()): ?>
                                <?php 
                                    // Generate a safe modal ID by removing special characters
                                    $modal_id = 'delete_' . preg_replace('/[^a-zA-Z0-9]/', '_', $row['member_id']);
                                ?>
                                <tr>
                                    <td><?php echo htmlspecialchars($row['member_id']); ?></td>
                                    <td>
                                        <?php 
                                            echo htmlspecialchars($row['last_name']) . ', ' . 
                                                 htmlspecialchars($row['first_name']) . 
                                                 (!empty($row['middle_name']) ? ' ' . htmlspecialchars($row['middle_name'][0]) . '.' : '');
                                        ?>
                                    </td>
                                    <td>
                                        <div><?php echo htmlspecialchars($row['email']); ?></div>
                                        <small class="text-muted"><?php echo htmlspecialchars($row['contact_num']); ?></small>
                                    </td>
                                    <td>
                                        <?php
                                            $status_class = '';
                                            switch ($row['status']) {
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
                                        <span class="<?php echo $status_class; ?>">
                                            <?php echo htmlspecialchars($row['status']); ?>
                                        </span>
                                    </td>
                                    <td>₱<?php echo number_format($row['total_fee_amount'], 2); ?></td>
                                    <td><?php echo htmlspecialchars($row['semester_count'] ?? 'N/A'); ?> semester(s)</td>
                                    <td>
                                    <div class="action-buttons d-flex justify-content-center">
                                        <a href="view_member.php?id=<?php echo htmlspecialchars(urlencode($row['member_id'])); ?>" 
                                        class="btn btn-info text-white" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </a>

                                        <?php if (in_array($_SESSION['officer_role'], ['intel_treasurer', 'intel_president'])): ?>
                                            <a href="edit_member.php?id=<?php echo htmlspecialchars(urlencode($row['member_id'])); ?>" 
                                            class="btn btn-warning text-white" title="Edit">
                                                <i class="fas fa-edit"></i>
                                            </a>

                                            <button type="button" class="btn btn-danger" data-bs-toggle="modal" 
                                                    data-bs-target="#delete_<?php echo htmlspecialchars($row['member_id']); ?>">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                        <?php endif; ?>
                                    </div>
                                        
                                        <!-- Delete Confirmation Modal -->
                                        <div class="modal fade" id="delete_<?php echo htmlspecialchars($row['member_id']); ?>" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header bg-danger text-white">
                                                        <h5 class="modal-title" id="deleteModalLabel">Confirm Deletion</h5>
                                                    </div>
                                                    <div class="modal-body">
                                                        <p>Are you sure you want to delete member <strong><?php echo htmlspecialchars($row['first_name'] . ' ' . $row['last_name']); ?></strong>?</p>
                                                        <p class="text-danger"><small>This action cannot be undone.</small></p>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                        <a href="delete_member.php?id=<?php echo htmlspecialchars(urlencode($row['member_id'])); ?>" class="btn btn-danger">Delete</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            <?php endwhile; ?>
                        </tbody>
                    </table>
                </div>
                
                <!-- Pagination -->
                <?php if($total_pages > 1): ?>
                    <div class="d-flex justify-content-between align-items-center mt-4">
                        <div>
                            <p class="text-muted">Showing <?php echo min($offset + 1, $total_records); ?> to <?php echo min($offset + $records_per_page, $total_records); ?> of <?php echo $total_records; ?> members</p>
                        </div>
                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <!-- Previous Button -->
                                <li class="page-item <?php echo ($page <= 1) ? 'disabled' : ''; ?>">
                                    <a class="page-link" href="?page=<?php echo $page - 1; ?><?php echo !empty($search) ? '&search=' . urlencode($search) : ''; ?><?php echo !empty($status_filter) ? '&status=' . urlencode($status_filter) : ''; ?><?php echo !empty($semester_filter) ? '&semester=' . urlencode($semester_filter) : ''; ?>" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                
                                <!-- Page Numbers -->
                                <?php for($i = max(1, $page - 2); $i <= min($page + 2, $total_pages); $i++): ?>
                                    <li class="page-item <?php echo ($page == $i) ? 'active' : ''; ?>">
                                        <a class="page-link" href="?page=<?php echo $i; ?><?php echo !empty($search) ? '&search=' . urlencode($search) : ''; ?><?php echo !empty($status_filter) ? '&status=' . urlencode($status_filter) : ''; ?><?php echo !empty($semester_filter) ? '&semester=' . urlencode($semester_filter) : ''; ?>">
                                            <?php echo $i; ?>
                                        </a>
                                    </li>
                                <?php endfor; ?>
                                
                                <!-- Next Button -->
                                <li class="page-item <?php echo ($page >= $total_pages) ? 'disabled' : ''; ?>">
                                    <a class="page-link" href="?page=<?php echo $page + 1; ?><?php echo !empty($search) ? '&search=' . urlencode($search) : ''; ?><?php echo !empty($status_filter) ? '&status=' . urlencode($status_filter) : ''; ?><?php echo !empty($semester_filter) ? '&semester=' . urlencode($semester_filter) : ''; ?>" aria-label="Next">
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
                    <h3>No members found</h3>
                    <p class="text-muted">
                        <?php if(!empty($search) || !empty($status_filter) || !empty($semester_filter)): ?>
                            Try adjusting your search criteria or filters.
                        <?php else: ?>
                            No members have been added yet. Click the "Add New Member" button to get started.
                        <?php endif; ?>
                    </p>
                    <?php if(!empty($search) || !empty($status_filter) || !empty($semester_filter)): ?>
                        <a href="members.php" class="btn btn-secondary mt-3">
                            <p><i class="fas fa-sync-alt"></i> Reset All Filter</p>
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
                    url: "fetch_members.php",
                    method: "GET",
                    data: { search: query },
                    success: function(response) {
                        $("#membersTableBody").html(response); // Update table dynamically
                    }
                });
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