<?php
    include('database.php');

    $search_query = isset($_GET['search']) ? trim($_GET['search']) : '';

    $sql = "SELECT * FROM activity_logs";

    if (!empty($search_query)) {
        $sql .= " WHERE action LIKE '%$search_query%' OR description LIKE '%$search_query%' OR officer_id LIKE '%$search_query%'";
    }

    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while ($log = $result->fetch_assoc()) {
            echo "<tr>
                    <td>{$log['log_id']}</td>
                    <td>{$log['officer_id']}</td>
                    <td>{$log['action']}</td>
                    <td>{$log['description']}</td>
                    <td>{$log['date']}</td>
                </tr>";
        }
    } else {
        echo "<tr><td colspan='5' class='text-center text-muted'>No results found</td></tr>";
    }
?>