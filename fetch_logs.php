<?php
require_once('database.php');
require_once('functions.php');

session_start();
$officer_id = $_SESSION['officer_id'] ?? null;

// Check if user is logged in
if (!$officer_id) {
    echo "Access denied";
    exit();
}

// Get search term
$search = isset($_GET['search']) ? trim($_GET['search']) : '';
$search_sql = '';

if (!empty($search)) {
    $search_sql = "WHERE al.action LIKE ? OR al.description LIKE ? OR al.officer_id LIKE ? OR CONCAT(m.first_name, ' ', m.last_name) LIKE ?";
}

// Prepare query with limit for performance
$query = "SELECT al.*, CONCAT(m.first_name, ' ', m.last_name) AS officer_name,
          CASE
            WHEN al.action = 'Member Deletion' THEN (
                SELECT CONCAT(member_data, '') FROM deleted_members 
                WHERE description IN (al.description, SUBSTRING_INDEX(al.description, ' (Deleted by', 1))
                LIMIT 1
            )
            ELSE NULL
          END AS member_data
          FROM activity_logs al
          LEFT JOIN officers o ON al.officer_id = o.officer_id
          LEFT JOIN members m ON o.member_id = m.member_id
          $search_sql
          ORDER BY al.date DESC 
          LIMIT 50";

$stmt = $conn->prepare($query);

if (!empty($search)) {
    $search_param = "%" . $search . "%";
    $stmt->bind_param("ssss", $search_param, $search_param, $search_param, $search_param);
}

$stmt->execute();
$result = $stmt->get_result();

// Generate table rows for output
if ($result->num_rows > 0) {
    while ($log = $result->fetch_assoc()) {
        echo "<tr>";
        echo "<td>" . htmlspecialchars($log['log_id']) . "</td>";
        echo "<td>" . htmlspecialchars($log['officer_id']) . "</td>";
        echo "<td>" . htmlspecialchars($log['officer_name'] ?? 'Unknown') . "</td>";
        echo "<td>" . htmlspecialchars($log['action']) . "</td>";
        echo "<td>" . htmlspecialchars($log['description']) . "</td>";
        echo "<td>" . htmlspecialchars($log['date']) . "</td>";
        echo "<td>";
        if ($log['action'] == 'Member Deletion' && !empty($log['member_data'])) {
            echo "<form method='POST' action='activity_logs.php' onsubmit=\"return confirm('Are you sure you want to restore this member?');\">";
            echo "<input type='hidden' name='log_id' value='" . $log['log_id'] . "'>";
            echo "<button type='submit' name='restore_member' class='btn btn-success btn-restore'>";
            echo "<i class='fas fa-user-plus'></i> Restore";
            echo "</button>";
            echo "</form>";
        }
        echo "</td>";
        echo "</tr>";
    }
} else {
    echo "<tr><td colspan='7' class='text-center'>No logs found</td></tr>";
}
?>