<?php
include('database.php');

$search_query = isset($_GET['search']) ? trim($_GET['search']) : '';

if (!empty($search_query)) {
    echo "Search Query: " . htmlspecialchars($search_query); // Debugging step
}

$sql = "SELECT p.*, m.first_name, m.last_name FROM payments p JOIN members m ON p.member_id = m.member_id";

if (!empty($search_query)) {
    $sql .= " WHERE p.payment_id LIKE '%$search_query%' OR m.first_name LIKE '%$search_query%' OR m.last_name LIKE '%$search_query%' OR p.amount LIKE '%$search_query%' OR p.payment_date LIKE '%$search_query%'";
}

$result = $conn->query($sql);
if ($result->num_rows > 0) {
    while ($payment = $result->fetch_assoc()) {
        echo "<tr>
                <td>{$payment['payment_id']}</td>
                <td>{$payment['first_name']} {$payment['last_name']}</td>
                <td>{$payment['member_id']}</td>
                <td>₱" . number_format($payment['amount'], 2) . "</td>
                <td>{$payment['payment_date']}</td>
              </tr>";
    }
} else {
    echo "<tr><td colspan='5' class='text-center text-muted'>No results found</td></tr>";
}
?>