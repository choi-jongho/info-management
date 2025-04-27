<?php
    require_once('database.php');
    require_once('functions.php');

    session_start();
    $officer_id = $_SESSION['officer_id'] ?? null;

    if (!$officer_id) {
        header("Location: login.php");
        exit();
    }

    $logs_per_page = 10;
    $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
    $offset = ($page - 1) * $logs_per_page;

    $search_query = isset($_GET['search']) ? trim($_GET['search']) : "";
    $search_sql = "";

    if (!empty($search_query)) {
        $search_sql = "WHERE al.action LIKE ? OR al.description LIKE ? OR al.officer_id LIKE ? OR CONCAT(m.first_name, ' ', m.last_name) LIKE ?";
    }

    // Fetch logs
    $query = "SELECT al.*, CONCAT(m.first_name, ' ', m.last_name) AS officer_name,
        CASE WHEN al.action = 'Member Deletion' THEN (
            SELECT member_data FROM deleted_members 
            WHERE description IN (al.description, SUBSTRING_INDEX(al.description, ' (Deleted by', 1)) LIMIT 1
        ) ELSE NULL END AS member_data,
        CASE WHEN al.action = 'Member Deletion' THEN (
            SELECT fees_data FROM deleted_members 
            WHERE description IN (al.description, SUBSTRING_INDEX(al.description, ' (Deleted by', 1)) LIMIT 1
        ) ELSE NULL END AS fees_data,
        CASE WHEN al.action = 'Member Deletion' THEN (
            SELECT payments_data FROM deleted_members 
            WHERE description IN (al.description, SUBSTRING_INDEX(al.description, ' (Deleted by', 1)) LIMIT 1
        ) ELSE NULL END AS payments_data,
        CASE WHEN al.action = 'Member Deletion' THEN (
            SELECT receipts_data FROM deleted_members 
            WHERE description IN (al.description, SUBSTRING_INDEX(al.description, ' (Deleted by', 1)) LIMIT 1
        ) ELSE NULL END AS receipts_data
        FROM activity_logs al
        LEFT JOIN officers o ON al.officer_id = o.officer_id
        LEFT JOIN members m ON o.member_id = m.member_id
        $search_sql
        ORDER BY al.date DESC 
        LIMIT ?, ?";

    $stmt = $conn->prepare($query);
    if (!empty($search_query)) {
        $search_param = "%" . $search_query . "%";
        $stmt->bind_param("ssssii", $search_param, $search_param, $search_param, $search_param, $offset, $logs_per_page);
    } else {
        $stmt->bind_param("ii", $offset, $logs_per_page);
    }
    $stmt->execute();
    $result = $stmt->get_result();

    // Count logs
    $count_query = "SELECT COUNT(*) AS count FROM activity_logs al
    LEFT JOIN officers o ON al.officer_id = o.officer_id
    LEFT JOIN members m ON o.member_id = m.member_id
    $search_sql";
    $total_logs_stmt = $conn->prepare($count_query);
    if (!empty($search_query)) {
        $total_logs_stmt->bind_param("ssss", $search_param, $search_param, $search_param, $search_param);
    }
    $total_logs_stmt->execute();
    $total_logs = $total_logs_stmt->get_result()->fetch_assoc()['count'];
    $total_pages = ceil($total_logs / $logs_per_page);

    $display_start = $offset + 1;
    $display_end = min($offset + $logs_per_page, $total_logs);

    // Restore member
    if (isset($_POST['restore_member']) && isset($_POST['log_id'])) {
        $log_id = $_POST['log_id'];

        $verify_stmt = $conn->prepare("
            SELECT al.log_id, al.description, 
                (SELECT member_data FROM deleted_members WHERE description IN (al.description, SUBSTRING_INDEX(al.description, ' (Deleted by', 1)) LIMIT 1) AS member_data,
                (SELECT fees_data FROM deleted_members WHERE description IN (al.description, SUBSTRING_INDEX(al.description, ' (Deleted by', 1)) LIMIT 1) AS fees_data,
                (SELECT payments_data FROM deleted_members WHERE description IN (al.description, SUBSTRING_INDEX(al.description, ' (Deleted by', 1)) LIMIT 1) AS payments_data,
                (SELECT receipts_data FROM deleted_members WHERE description IN (al.description, SUBSTRING_INDEX(al.description, ' (Deleted by', 1)) LIMIT 1) AS receipts_data
            FROM activity_logs al
            WHERE al.log_id = ? AND al.action = 'Member Deletion'
        ");
        $verify_stmt->bind_param("i", $log_id);
        $verify_stmt->execute();
        $log_result = $verify_stmt->get_result();

        if ($log_result->num_rows > 0) {
            $log_data = $log_result->fetch_assoc();

            $member_data = json_decode($log_data['member_data'], true);
            $fees_data = json_decode($log_data['fees_data'], true);
            $payments_data = json_decode($log_data['payments_data'], true);
            $receipts_data = json_decode($log_data['receipts_data'], true);

            if ($member_data && is_array($member_data)) {
                $conn->begin_transaction();

                try {
                    $check_stmt = $conn->prepare("SELECT member_id FROM members WHERE member_id = ?");
                    $check_stmt->bind_param("s", $member_data['member_id']);
                    $check_stmt->execute();
                    $exists = $check_stmt->get_result()->num_rows > 0;

                    if (!$exists) {
                        // Insert member
                        $insert_stmt = $conn->prepare("
                            INSERT INTO members (member_id, first_name, last_name, middle_name, contact_num, email, status, membership_date)
                            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
                        ");
                        $insert_stmt->bind_param(
                            "ssssssss",
                            $member_data['member_id'],
                            $member_data['first_name'],
                            $member_data['last_name'],
                            $member_data['middle_name'],
                            $member_data['contact_num'],
                            $member_data['email'],
                            $member_data['status'],
                            $member_data['membership_date']
                        );
                        $insert_stmt->execute();

                        // Restore fees
                        foreach ($fees_data as $fee) {
                            $insert_fee_stmt = $conn->prepare("
                                INSERT INTO fees (member_id, fee_amount, fee_type, semester, school_year, status)
                                VALUES (?, ?, ?, ?, ?, ?)
                            ");
                            $insert_fee_stmt->bind_param(
                                "sdssss",
                                $fee['member_id'],
                                $fee['fee_amount'],
                                $fee['fee_type'],
                                $fee['semester'],
                                $fee['school_year'],
                                $fee['status']
                            );
                            $insert_fee_stmt->execute();
                        }

                        // Restore payments first and track payment IDs
                        $payment_map = []; // To keep track of old payment_id -> new payment_id
                        foreach ($payments_data as $payment) {
                            // Check if payment_id exists as primary key
                            $check_payment = $conn->prepare("SELECT payment_id FROM payments WHERE payment_id = ?");
                            $check_payment->bind_param("s", $payment['payment_id']);
                            $check_payment->execute();
                            $payment_exists = $check_payment->get_result()->num_rows > 0;
                            
                            if (!$payment_exists) {
                                $insert_payment_stmt = $conn->prepare("
                                    INSERT INTO payments (payment_id, member_id, fee_type, amount, semester, school_year, payment_date)
                                    VALUES (?, ?, ?, ?, ?, ?, ?)
                                ");
                                $insert_payment_stmt->bind_param(
                                    "sssdsss",
                                    $payment['payment_id'],
                                    $payment['member_id'],
                                    $payment['fee_type'],
                                    $payment['amount'],
                                    $payment['semester'],
                                    $payment['school_year'],
                                    $payment['payment_date']
                                );
                                $insert_payment_stmt->execute();
                                $payment_map[$payment['payment_id']] = $payment['payment_id'];
                            } else {
                                $payment_map[$payment['payment_id']] = $payment['payment_id'];
                            }
                        }

                        // Now restore receipts, only if the payment exists
                        foreach ($receipts_data as $receipt) {
                            // Only insert if the corresponding payment exists
                            $check_payment = $conn->prepare("SELECT payment_id FROM payments WHERE payment_id = ?");
                            $check_payment->bind_param("s", $receipt['payment_id']);
                            $check_payment->execute();
                            $payment_exists = $check_payment->get_result()->num_rows > 0;
                            
                            if ($payment_exists) {
                                $insert_receipt_stmt = $conn->prepare("
                                    INSERT INTO receipts (receipt_id, payment_id, member_id, officer_id, total_amount, receipt_date)
                                    VALUES (?, ?, ?, ?, ?, ?)
                                ");
                                $insert_receipt_stmt->bind_param(
                                    "ssssds",
                                    $receipt['receipt_id'],
                                    $receipt['payment_id'],
                                    $receipt['member_id'],
                                    $receipt['officer_id'],
                                    $receipt['total_amount'],
                                    $receipt['receipt_date']
                                );
                                $insert_receipt_stmt->execute();
                            }
                        }

                        // Delete from deleted_members
                        $delete_stmt = $conn->prepare("DELETE FROM deleted_members 
                            WHERE description IN (?, SUBSTRING_INDEX(?, ' (Deleted by', 1))");
                        $delete_stmt->bind_param("ss", $log_data['description'], $log_data['description']);
                        $delete_stmt->execute();

                        log_activity("Member Restoration", 
                            "Member {$member_data['first_name']} {$member_data['last_name']} (ID: {$member_data['member_id']}) was restored.",
                            $officer_id
                        );

                        $conn->commit();
                        $_SESSION['success_message'] = "Member and associated data successfully restored.";
                        header("Location: members.php");
                        exit();
                    } else {
                        $conn->rollback();
                        $_SESSION['error_message'] = "Cannot restore: Student ID already exists.";
                        header("Location: members.php");
                        exit();
                    }
                } catch (Exception $e) {
                    $conn->rollback();
                    $_SESSION['error_message'] = "Restoration failed: " . $e->getMessage();
                    header("Location: members.php");
                    exit();
                }
            } else {
                $_SESSION['error_message'] = "Invalid member data format.";
                header("Location: members.php");
                exit();
            }
        } else {
            $_SESSION['error_message'] = "Invalid log entry.";
            header("Location: members.php");
            exit();
        }

        header("Location: activity_log.php" . (!empty($search_query) ? "?search=" . urlencode($search_query) : ""));
        exit();
    }
?>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Activity Logs | INTEL</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="icon" href="images/info-tech.svg">
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
        .bg-navy {
            background-color: #001f3f !important;
        }
        .btn-navy {
            background-color: #001f3f !important;
            border-color: #001f3f !important;
            color: #fff !important;
        }
        .table-container {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            padding: 20px;
            margin-top: 20px;
        }
        .pagination .page-item.active .page-link {
            background-color: #001f3f;
            border-color: #001f3f;
        }
        .btn-restore {
            padding: 0.25rem 0.5rem;
            font-size: 0.75rem;
        }
        .alert {
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <?php include('navbar.php'); ?>

    <main class="container my-4">
        <div class="table-container">
            <h2 class="text-center mb-4"><i class="fas fa-clipboard-list me-2"></i>Activity Logs</h2>

            <!-- Alert Messages -->
            <?php if (isset($_SESSION['success_message'])): ?>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <?php echo htmlspecialchars($_SESSION['success_message']); ?>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <?php unset($_SESSION['success_message']); ?>
            <?php endif; ?>

            <?php if (isset($_SESSION['error_message'])): ?>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <?php echo htmlspecialchars($_SESSION['error_message']); ?>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <?php unset($_SESSION['error_message']); ?>
            <?php endif; ?>

            <!-- Search Bar -->
            <form method="GET" action="" class="mb-3">
                <div class="input-group">
                    <input type="text" class="form-control me-2" id="searchBar" name="search" placeholder="Search logs..." value="<?php echo htmlspecialchars($search_query); ?>">
                    <button type="submit" class="btn btn-navy"><i class="fas fa-search"></i> Search</button>
                </div>
            </form>

            <!-- Responsive Table Container -->
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Log ID</th>
                            <th>Officer ID</th>
                            <th>Officer Name</th>
                            <th>Action</th>
                            <th>Description</th>
                            <th>Timestamp</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="logsTableBody">
                        <?php while ($log = $result->fetch_assoc()): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($log['log_id']); ?></td>
                                <td><?php echo htmlspecialchars($log['officer_id']); ?></td>
                                <td><?php echo htmlspecialchars($log['officer_name'] ?? 'Unknown'); ?></td>
                                <td><?php echo htmlspecialchars($log['action']); ?></td>
                                <td><?php echo htmlspecialchars($log['description']); ?></td>
                                <td><?php echo htmlspecialchars($log['date']); ?></td>
                                <td>
                                    <?php if ($log['action'] == 'Member Deletion' && !empty($log['member_data'])): ?>
                                        <?php 
                                            // Parse the member data to get the name (assuming it's stored in JSON format)
                                            $memberData = json_decode($log['member_data'], true);
                                            $memberName = !empty($memberData['first_name']) && !empty($memberData['last_name']) ? 
                                                        $memberData['first_name'] . ' ' . $memberData['last_name'] : 
                                                        'Unknown Member';
                                            // Generate a safe modal ID
                                            $modal_id = 'restore_' . preg_replace('/[^a-zA-Z0-9]/', '_', $log['log_id']);
                                        ?>
                                        <form method="POST" action="">
                                            <input type="hidden" name="log_id" value="<?php echo $log['log_id']; ?>">
                                            <!-- Using Bootstrap's data attributes to trigger a modal without JavaScript -->
                                            <button type="button" class="btn btn-success btn-restore" data-bs-toggle="modal" data-bs-target="#<?php echo $modal_id; ?>">
                                                <i class="fas fa-user-plus"></i> Restore
                                            </button>
                                            
                                            <!-- Individual modal for each row -->
                                            <div class="modal fade" id="<?php echo $modal_id; ?>" tabindex="-1" aria-labelledby="restoreModalLabel<?php echo $log['log_id']; ?>" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header bg-success text-white">
                                                            <h5 class="modal-title" id="restoreModalLabel<?php echo $log['log_id']; ?>">Restore Member</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <p>Are you sure you want to restore member <strong><?php echo htmlspecialchars($memberName); ?></strong>?</p>
                                                            <p>This will reinstate their account with all previous data and settings.</p>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                            <button type="submit" name="restore_member" class="btn btn-success">
                                                                <i class="fas fa-user-plus"></i> Confirm Restore
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    <?php endif; ?>
                                </td>
                            </tr>
                        <?php endwhile; ?>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <?php if ($total_pages > 1): ?>
                <div class="d-flex justify-content-between align-items-center mt-4">
                    <div>
                        <p class="text-muted">
                            Showing <?php echo $display_start; ?> to <?php echo $display_end; ?> of <?php echo $total_logs; ?> logs
                        </p>
                    </div>
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                            <!-- Previous Button -->
                            <li class="page-item <?php echo ($page <= 1) ? 'disabled' : ''; ?>">
                                <a class="page-link" href="?page=<?php echo $page - 1; ?><?php echo !empty($search_query) ? '&search='.urlencode($search_query) : ''; ?>" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>

                            <!-- Page Numbers -->
                            <?php for ($i = max(1, $page - 2); $i <= min($page + 2, $total_pages); $i++): ?>
                                <li class="page-item <?php echo ($page == $i) ? 'active' : ''; ?>">
                                    <a class="page-link" href="?page=<?php echo $i; ?><?php echo !empty($search_query) ? '&search='.urlencode($search_query) : ''; ?>"><?php echo $i; ?></a>
                                </li>
                            <?php endfor; ?>

                            <!-- Next Button -->
                            <li class="page-item <?php echo ($page >= $total_pages) ? 'disabled' : ''; ?>">
                                <a class="page-link" href="?page=<?php echo $page + 1; ?><?php echo !empty($search_query) ? '&search='.urlencode($search_query) : ''; ?>" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            <?php endif; ?>
        </div>
    </main>

    <?php include('footer.php'); ?>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            // Setup auto-dismissing alerts
            setTimeout(function() {
                $('.alert').alert('close');
            }, 5000);

            // Live search functionality
            $("#searchBar").on("keyup", function() {
                var query = $(this).val();
                $.ajax({
                    url: "fetch_logs.php",
                    method: "GET",
                    data: { search: query },
                    success: function(response) {
                        $("#logsTableBody").html(response); // Update table dynamically
                    }
                });
            });
        });
    </script>
</body>
</html>