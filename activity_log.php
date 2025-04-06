<?php
    require_once('database.php');
    require_once('functions.php');

    // Start session
    session_start();

    // Define pagination variables
    $logs_per_page = 10;
    $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
    $offset = ($page - 1) * $logs_per_page;

    // Search functionality
    $search_query = isset($_GET['search']) ? trim($_GET['search']) : "";
    $search_sql = "";

    if (!empty($search_query)) {
        $search_sql = "WHERE action LIKE ? OR description LIKE ? OR officer_id LIKE ?";
    }

    // Fetch logs with search filter and pagination
    $stmt = $conn->prepare("SELECT * FROM activity_logs $search_sql ORDER BY date DESC LIMIT ?, ?");
    if (!empty($search_query)) {
        $search_param = "%" . $search_query . "%";
        $stmt->bind_param("sssii", $search_param, $search_param, $search_param, $offset, $logs_per_page);
    } else {
        $stmt->bind_param("ii", $offset, $logs_per_page);
    }

    $stmt->execute();
    $result = $stmt->get_result();

    // Count total logs for pagination
    $total_logs_stmt = $conn->prepare("SELECT COUNT(*) AS count FROM activity_logs $search_sql");
    if (!empty($search_query)) {
        $total_logs_stmt->bind_param("sss", $search_param, $search_param, $search_param);
    }
    $total_logs_stmt->execute();
    $total_logs = $total_logs_stmt->get_result()->fetch_assoc()['count'];
    $total_pages = ceil($total_logs / $logs_per_page);

    // Calculate displayed range
    $display_start = $offset + 1;
    $display_end = min($offset + $logs_per_page, $total_logs);
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
    </style>
</head>
<body>
    <?php include('navbar.php'); ?>

    <main class="container my-4">
        <div class="table-container">
            <h2 class="text-center mb-4"><i class="fas fa-clipboard-list me-2"></i>Activity Logs</h2>

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
                            <th>Action</th>
                            <th>Description</th>
                            <th>Timestamp</th>
                        </tr>
                    </thead>
                    <tbody id="logsTableBody">
                        <?php while ($log = $result->fetch_assoc()): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($log['log_id']); ?></td>
                                <td><?php echo htmlspecialchars($log['officer_id']); ?></td>
                                <td><?php echo htmlspecialchars($log['action']); ?></td>
                                <td><?php echo htmlspecialchars($log['description']); ?></td>
                                <td><?php echo htmlspecialchars($log['date']); ?></td>
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
                                <a class="page-link" href="?page=<?php echo $page - 1; ?>" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>

                            <!-- Page Numbers -->
                            <?php for ($i = max(1, $page - 2); $i <= min($page + 2, $total_pages); $i++): ?>
                                <li class="page-item <?php echo ($page == $i) ? 'active' : ''; ?>">
                                    <a class="page-link" href="?page=<?php echo $i; ?>"><?php echo $i; ?></a>
                                </li>
                            <?php endfor; ?>

                            <!-- Next Button -->
                            <li class="page-item <?php echo ($page >= $total_pages) ? 'disabled' : ''; ?>">
                                <a class="page-link" href="?page=<?php echo $page + 1; ?>" aria-label="Next">
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