<?php
    session_start();
    require_once('database.php');
    require_once('functions.php');

    // Check if officer is logged in  
    $officer_id = $_SESSION['officer_id'] ?? null;
    if (!$officer_id) {
        echo "Unauthorized access";
        exit();
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
        $total_payments_stmt->bind_param("sssssss", $search_param, $search_param, $search_param, $search_param, $search_param, $search_param, $search_param);
    }
    $total_payments_stmt->execute();
    $total_payments = $total_payments_stmt->get_result()->fetch_assoc()['count'];
    $total_pages = ceil($total_payments / $payments_per_page);

    // Calculate displayed range
    $display_start = $offset + 1;
    $display_end = min($offset + $payments_per_page, $total_payments);

    // Generate table HTML
    $html = '';
    if ($payments_result->num_rows > 0) {
        while ($payment = $payments_result->fetch_assoc()) {
            $html .= '<tr>';
            $html .= '<td>' . htmlspecialchars($payment['payment_id']) . '</td>';
            $html .= '<td>' . htmlspecialchars($payment['first_name'] . ' ' . $payment['last_name']) . '</td>';
            $html .= '<td>' . htmlspecialchars($payment['member_id']) . '</td>';
            $html .= '<td>₱' . number_format($payment['amount'], 2) . '</td>';
            $html .= '<td>' . htmlspecialchars($payment['fee_type']) . '</td>';
            $html .= '<td>' . htmlspecialchars($payment['payment_date']) . '</td>';
            $html .= '</tr>';
        }
    } else {
        $html = '<tr><td colspan="6" class="text-center text-muted">No results found</td></tr>';
    }

    // Send pagination data if requested
    if (isset($_GET['update_pagination']) && $_GET['update_pagination'] == 1) {
        $pagination_data = [
            'current_page' => $page,
            'total_pages' => $total_pages,
            'total_payments' => $total_payments,
            'display_start' => $display_start,
            'display_end' => $display_end
        ];
        echo $html . '||PAGINATION||' . json_encode($pagination_data);
    } else {
        echo $html;
    }
?>