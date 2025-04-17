<?php
    session_start();

    // Check if officer is logged in  
    $officer_id = $_SESSION['officer_id'] ?? null;
    if (!$officer_id) {
        exit("Unauthorized access.");
    }

    require_once('database.php');
    require_once('functions.php');

    // Get search and pagination parameters
    $search_query = isset($_GET['search']) ? trim($_GET['search']) : "";
    $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
    $payments_per_page = 10;
    $offset = ($page - 1) * $payments_per_page;

    $search_sql = "";

    if (!empty($search_query)) {
        $search_sql = "WHERE p.payment_id LIKE ? OR p.member_id LIKE ? OR m.first_name LIKE ? OR m.last_name LIKE ? OR p.fee_type LIKE ? OR p.amount LIKE ? OR p.payment_date LIKE ?";
    }

    $stmt = $conn->prepare("SELECT p.*, m.first_name, m.last_name FROM payments p 
                            JOIN members m ON p.member_id = m.member_id 
                            $search_sql
                            ORDER BY p.payment_date DESC 
                            LIMIT ?, ?");

    if (!empty($search_query)) {
        $search_param = "%" . $search_query . "%";
        $stmt->bind_param("sssssssii", $search_param, $search_param, $search_param, $search_param, $search_param, $search_param, $search_param, $offset, $payments_per_page);
    } else {
        $stmt->bind_param("ii", $offset, $payments_per_page);
    }

    $stmt->execute();
    $result = $stmt->get_result();

    // Also get the total count for pagination info
    $total_payments_stmt = $conn->prepare("SELECT COUNT(*) AS count FROM payments p 
                                        JOIN members m ON p.member_id = m.member_id 
                                        $search_sql");
                                        
    if (!empty($search_query)) {
        $total_payments_stmt->bind_param("sssssss", $search_param, $search_param, $search_param, $search_param, $search_param, $search_param, $search_param);
    }

    $total_payments_stmt->execute();
    $total_payments = $total_payments_stmt->get_result()->fetch_assoc()['count'];
    $total_pages = ceil($total_payments / $payments_per_page);

    if ($result->num_rows > 0) {
        while ($payment = $result->fetch_assoc()) {
            echo '<tr>';
            echo '<td>' . htmlspecialchars($payment['payment_id']) . '</td>';
            echo '<td>' . htmlspecialchars($payment['first_name'] . ' ' . $payment['last_name']) . '</td>';
            echo '<td>' . htmlspecialchars($payment['member_id']) . '</td>';
            echo '<td>₱' . number_format($payment['amount'], 2) . '</td>';
            echo '<td>' . htmlspecialchars($payment['fee_type']) . '</td>';
            echo '<td>' . htmlspecialchars($payment['payment_date']) . '</td>';
            echo '</tr>';
        }
    } else {
        echo '<tr><td colspan="6" class="text-center text-muted">No results found</td></tr>';
    }

    // If we need to update pagination links as well, we can output additional data
    if (isset($_GET['update_pagination']) && $_GET['update_pagination'] == '1') {
        echo "||PAGINATION||";
        echo json_encode([
            'total_pages' => $total_pages,
            'current_page' => $page,
            'total_payments' => $total_payments,
            'display_start' => ($offset + 1),
            'display_end' => min($offset + $payments_per_page, $total_payments)
        ]);
    }

    $stmt->close();
    $conn->close();
?>