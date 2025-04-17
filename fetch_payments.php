<?php
    session_start();

    // Check if officer is logged in  
    $officer_id = $_SESSION['officer_id'] ?? null;
    if (!$officer_id) {
        exit("Unauthorized access.");
    }

    require_once('database.php');
    require_once('functions.php');

    $search_query = isset($_GET['search']) ? trim($_GET['search']) : "";
    $search_sql = "";

    if (!empty($search_query)) {
        $search_sql = "WHERE p.payment_id LIKE ? OR p.member_id LIKE ? OR m.first_name LIKE ? OR m.last_name LIKE ? OR p.fee_type LIKE ? OR p.amount LIKE ? OR p.payment_date LIKE ?";
    }

    $stmt = $conn->prepare("SELECT p.*, m.first_name, m.last_name FROM payments p 
                            JOIN members m ON p.member_id = m.member_id 
                            $search_sql
                            ORDER BY p.payment_date DESC");

    if (!empty($search_query)) {
        $search_param = "%" . $search_query . "%";
        $stmt->bind_param("sssssss", $search_param, $search_param, $search_param, $search_param, $search_param, $search_param, $search_param);
    }

    $stmt->execute();
    $result = $stmt->get_result();

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

    $stmt->close();
    $conn->close();
?>