<?php
    require_once('database.php');
    require_once('functions.php');

    session_start();
    $officer_id = $_SESSION['officer_id'] ?? null;

    // Check if user is logged in
    if (!$officer_id) {
        header("Location: login.php");
        exit();
    }

    // Get search term
    $search_query = isset($_GET['search']) ? trim($_GET['search']) : '';
    $search_sql = '';

    if (!empty($search_query)) {
        $search_sql = "WHERE al.action LIKE ? OR al.description LIKE ? OR al.officer_id LIKE ? OR CONCAT(m.first_name, ' ', m.last_name) LIKE ?";
    }

    // Query to fetch logs with the same structure as in activity_log.php
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
        LIMIT 20";

    $stmt = $conn->prepare($query);

    if (!empty($search_query)) {
        $search_param = "%" . $search_query . "%";
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
                // Parse the member data to get the name
                $memberData = json_decode($log['member_data'], true);
                $memberName = !empty($memberData['first_name']) && !empty($memberData['last_name']) ? 
                            $memberData['first_name'] . ' ' . $memberData['last_name'] : 
                            'Unknown Member';
                // Generate a safe modal ID
                $modal_id = 'restore_' . preg_replace('/[^a-zA-Z0-9]/', '_', $log['log_id']);
                
                echo "<form method='POST' action=''>";
                echo "<input type='hidden' name='log_id' value='" . $log['log_id'] . "'>";
                echo "<button type='button' class='btn btn-success btn-restore' data-bs-toggle='modal' data-bs-target='#" . $modal_id . "'>";
                echo "<i class='fas fa-user-plus'></i> Restore";
                echo "</button>";
                
                // Individual modal for each row
                echo "<div class='modal fade' id='" . $modal_id . "' tabindex='-1' aria-labelledby='restoreModalLabel" . $log['log_id'] . "' aria-hidden='true'>";
                echo "<div class='modal-dialog'>";
                echo "<div class='modal-content'>";
                echo "<div class='modal-header bg-success text-white'>";
                echo "<h5 class='modal-title' id='restoreModalLabel" . $log['log_id'] . "'>Restore Member</h5>";
                echo "<button type='button' class='btn-close' data-bs-dismiss='modal' aria-label='Close'></button>";
                echo "</div>";
                echo "<div class='modal-body'>";
                echo "<p>Are you sure you want to restore member <strong>" . htmlspecialchars($memberName) . "</strong>?</p>";
                echo "<p>This will reinstate their account with all previous data and settings.</p>";
                echo "</div>";
                echo "<div class='modal-footer'>";
                echo "<button type='button' class='btn btn-secondary' data-bs-dismiss='modal'>Cancel</button>";
                echo "<button type='submit' name='restore_member' class='btn btn-success'>";
                echo "<i class='fas fa-user-plus'></i> Confirm Restore";
                echo "</button>";
                echo "</div></div></div></div>";
                echo "</form>";
            }
            echo "</td>";
            echo "</tr>";
        }
    } else {
        echo "<tr><td colspan='7' class='text-center'>No logs found</td></tr>";
    }
?>