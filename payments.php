<?php
    session_start();

    // Check if officer is logged in  
    $officer_id = $_SESSION['officer_id'] ?? null;
    if (!$officer_id) {
        // Officer not logged in, redirect to login page
        header("Location: login.php");
        exit();
    }

    require_once('database.php');
    require_once('functions.php');

    $errors = [];
    $success = false;

    // Handle form submission for adding payments
    if ($_SERVER["REQUEST_METHOD"] === "POST") {
        $member_id = sanitize_input($_POST['member_id'] ?? '');
        $amount = sanitize_input($_POST['amount'] ?? '');
        $fee_type = sanitize_input($_POST['fee_type'] ?? ''); // Add fee_type field

        // Validate input
        if (empty($member_id)) {
            $errors[] = "Student ID is required.";
        }

        if (empty($amount)) {
            $errors[] = "Payment amount is required.";
        } elseif (!is_numeric($amount) || $amount <= 0) {
            $errors[] = "Payment amount must be a positive number.";
        }

        if (empty($fee_type)) {
            $errors[] = "Fee type is required.";
        }

        // Check if member exists
        if (empty($errors)) {
            $stmt = $conn->prepare("SELECT member_id FROM members WHERE member_id = ?");
            $stmt->bind_param("s", $member_id);
            $stmt->execute();
            $result = $stmt->get_result();

            if ($result->num_rows === 0) {
                $errors[] = "Student ID does not exist.";
            }

            $stmt->close();
        }

        // Add payment if no errors
        if (empty($errors)) {
            $stmt = $conn->prepare("INSERT INTO payments (member_id, fee_type, amount, payment_date) VALUES (?, ?, ?, NOW())");
            $stmt->bind_param("ssd", $member_id, $fee_type, $amount);

            if ($stmt->execute()) {
                $success = true;
                log_activity("Add Payment", "Payment of ₱$amount added for Student ID: $member_id with fee type: $fee_type");
            } else {
                $errors[] = "Failed to record the payment. Please try again.";
            }

            $stmt->close();
        }
    }

    // Define pagination variables
    $payments_per_page = 10;
    $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
    $offset = ($page - 1) * $payments_per_page;

    // Search functionality
    $search_query = isset($_GET['search']) ? trim($_GET['search']) : "";
    $search_sql = "";

    if (!empty($search_query)) {
        $search_sql = "WHERE p.payment_id LIKE ? OR p.member_id LIKE ? OR m.first_name LIKE ? OR m.last_name LIKE ? OR p.fee_type LIKE ? OR p.amount LIKE ? OR p.payment_date LIKE ?";
    }

    // Fetch payments with search filter and pagination  
    $stmt = $conn->prepare("SELECT p.*, m.first_name, m.last_name FROM payments p 
                            JOIN members m ON p.member_id = m.member_id 
                            $search_sql
                            ORDER BY p.payment_date DESC 
                            LIMIT ?, ?");
    if (!empty($search_query)) {
        $search_param = "%" . $search_query . "%";
        // Fixed: Changed from ssssssii to sssssssii for correct parameter binding
        $stmt->bind_param("sssssssii", $search_param, $search_param, $search_param, $search_param, $search_param, $search_param, $search_param, $offset, $payments_per_page);
    } else {
        $stmt->bind_param("ii", $offset, $payments_per_page);
    }

    $stmt->execute();
    $payments_result = $stmt->get_result();

    // Count total payments for pagination
    $total_payments_stmt = $conn->prepare("SELECT COUNT(*) AS count FROM payments p 
                                        JOIN members m ON p.member_id = m.member_id 
                                        $search_sql");
    if (!empty($search_query)) {
        // Fixed: Changed from ssssss to sssssss for correct parameter binding
        $total_payments_stmt->bind_param("sssssss", $search_param, $search_param, $search_param, $search_param, $search_param, $search_param, $search_param);
    }
    $total_payments_stmt->execute();
    $total_payments = $total_payments_stmt->get_result()->fetch_assoc()['count'];
    $total_pages = ceil($total_payments / $payments_per_page);

    // Calculate displayed range
    $display_start = $offset + 1;
    $display_end = min($offset + $payments_per_page, $total_payments);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payments | INTEL</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="icon" href="images/info-tech.svg">
</head>
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
            color: #fff !important;
        }
        .btn-navy:hover {
            background-color: #003366;
            border-color: #003366;
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
            margin-bottom: 20px;
        }
    </style>
<body>
    <!-- Include navigation bar -->
    <?php include('navbar.php'); ?>

    <main class="container my-5">
        <!-- Payment Records Table -->
        <div class="card">
            <div class="card-header bg-navy text-white">
                <h4 class="mb-0"><i class="fas fa-list me-2"></i>Payment Records</h4>
            </div>
            <!-- Search Bar -->
            <form method="GET" action="" class="m-3">
                <div class="input-group">
                    <input type="text" class="form-control me-2" id="searchBar" placeholder="Search payments..." name="search" value="<?php echo htmlspecialchars($search_query); ?>">
                    <button type="submit" class="btn btn-navy"><i class="fas fa-search"></i> Search</button>
                </div>
            </form>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Payment ID</th>
                                <th>Member Name</th>
                                <th>Student ID</th>
                                <th>Amount</th>
                                <th>Fee Type</th>
                                <th>Payment Date</th>
                            </tr>
                        </thead>
                        <tbody id="paymentTableBody">
                            <?php if ($total_payments > 0): ?> 
                                <?php if ($payments_result->num_rows > 0): ?>
                                    <?php while ($payment = $payments_result->fetch_assoc()): ?>
                                        <tr>
                                            <td><?php echo htmlspecialchars($payment['payment_id']); ?></td>
                                            <td><?php echo htmlspecialchars($payment['first_name'] . ' ' . $payment['last_name']); ?></td>
                                            <td><?php echo htmlspecialchars($payment['member_id']); ?></td>
                                            <td>₱<?php echo number_format($payment['amount'], 2); ?></td>
                                            <td><?php echo htmlspecialchars($payment['fee_type']); ?></td>
                                            <td><?php echo htmlspecialchars($payment['payment_date']); ?></td>
                                        </tr>
                                    <?php endwhile; ?>
                                <?php else: ?>
                                    <!-- Display 'No results found' when no matches for search -->
                                    <tr>
                                        <td colspan="6" class="text-center text-muted">No results found</td>
                                    </tr>
                                <?php endif; ?>
                            <?php else: ?>
                                <!-- Display 'No payments found' if there are no payments at all -->
                                <tr>
                                    <td colspan="6" class="text-center text-muted">No payments found</td>
                                </tr>
                            <?php endif; ?>
                        </tbody>
                    </table>    
                </div>
                <!-- Pagination -->
                <?php if ($total_pages > 1): ?>
                    <div class="d-flex justify-content-between align-items-center mt-4" id="paginationContainer" <?php echo ($total_pages <= 1) ? 'style="display: none;"' : ''; ?>>
                        <div>
                            <p class="text-muted" id="paginationInfo">
                                Showing <?php echo $display_start; ?> to <?php echo $display_end; ?> of <?php echo $total_payments; ?> payments
                            </p>
                        </div>
                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <!-- Previous Button -->
                                <li class="page-item <?php echo ($page <= 1) ? 'disabled' : ''; ?>">
                                    <a class="page-link" href="?page=<?php echo $page - 1; ?>&search=<?php echo urlencode($search_query); ?>" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>

                                <!-- Page Numbers -->
                                <?php for ($i = max(1, $page - 2); $i <= min($page + 2, $total_pages); $i++): ?>
                                    <li class="page-item <?php echo ($page == $i) ? 'active' : ''; ?>">
                                        <a class="page-link" href="?page=<?php echo $i; ?>&search=<?php echo urlencode($search_query); ?>"><?php echo $i; ?></a>
                                    </li>
                                <?php endfor; ?>

                                <!-- Next Button -->
                                <li class="page-item <?php echo ($page >= $total_pages) ? 'disabled' : ''; ?>">
                                    <a class="page-link" href="?page=<?php echo $page + 1; ?>&search=<?php echo urlencode($search_query); ?>" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                <?php endif; ?>
            </div>
        </div>
    </main>

    <!-- Include footer -->
    <?php include('footer.php'); ?>

    <!-- Bootstrap JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function(){
            // Function to update pagination display
            function updatePagination(paginationData) {
                if (!paginationData) return;
                
                // Update the "Showing X to Y of Z payments" text
                $('.text-muted:first').text(
                    `Showing ${paginationData.display_start} to ${paginationData.display_end} of ${paginationData.total_payments} payments`
                );
                
                // Update pagination links
                const paginationContainer = $('.pagination');
                paginationContainer.empty();
                
                // Previous button
                paginationContainer.append(`
                    <li class="page-item ${paginationData.current_page <= 1 ? 'disabled' : ''}">
                        <a class="page-link" href="?page=${paginationData.current_page - 1}&search=${encodeURIComponent($('#searchBar').val())}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                `);
                
                // Page numbers
                for (let i = Math.max(1, paginationData.current_page - 2); i <= Math.min(paginationData.current_page + 2, paginationData.total_pages); i++) {
                    paginationContainer.append(`
                        <li class="page-item ${paginationData.current_page == i ? 'active' : ''}">
                            <a class="page-link" href="?page=${i}&search=${encodeURIComponent($('#searchBar').val())}">${i}</a>
                        </li>
                    `);
                }
                
                // Next button
                paginationContainer.append(`
                    <li class="page-item ${paginationData.current_page >= paginationData.total_pages ? 'disabled' : ''}">
                        <a class="page-link" href="?page=${paginationData.current_page + 1}&search=${encodeURIComponent($('#searchBar').val())}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                `);
            }
            
            // Function to fetch payments
            function fetchPayments(query, page = 1) {
                $.ajax({
                    url: "fetch_payments.php",
                    method: "GET",
                    data: { 
                        search: query,
                        page: page,
                        update_pagination: 1
                    },
                    beforeSend: function() {
                        $("#paymentTableBody").html('<tr><td colspan="6" class="text-center"><i class="fas fa-spinner fa-spin"></i> Loading...</td></tr>');
                    },
                    success: function(response) {
                        const parts = response.split("||PAGINATION||");
                        const tableContent = parts[0];
                        const paginationData = parts[1] ? JSON.parse(parts[1]) : null;
                        
                        $("#paymentTableBody").html(tableContent);
                        
                        // Update pagination if data is available
                        if (paginationData) {
                            updatePagination(paginationData);
                            
                            // Show/hide pagination section based on total pages
                            if (paginationData.total_pages > 1) {
                                $('.d-flex.justify-content-between').show();
                            } else {
                                $('.d-flex.justify-content-between').hide();
                            }
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("Error fetching payments:", error);
                        $("#paymentTableBody").html('<tr><td colspan="6" class="text-center text-danger">Error loading data. Please try again.</td></tr>');
                    }
                });
            }
            
            // Search on keyup without debouncing
            $("#searchBar").on("keyup", function() {
                var query = $(this).val();
                $.ajax({
                    url: "fetch_payments.php",
                    method: "GET",
                    data: { search: query },
                    success: function(response) {
                        $("#paymentTableBody").html(response); // Update table dynamically
                    }
                });
            });
            
            // Handle direct pagination clicks
            $(document).on('click', '.pagination .page-link', function(e) {
                e.preventDefault();
                const href = $(this).attr('href');
                const urlParams = new URLSearchParams(href.split('?')[1]);
                const page = urlParams.get('page');
                const search = urlParams.get('search') || '';
                
                fetchPayments(search, page);
            });
            
            // Handle form submission (prevent default)
            $('form').on('submit', function(e) {
                e.preventDefault();
                const query = $('#searchBar').val();
                fetchPayments(query, 1);
            });
        });
    </script>
</body>
</html>