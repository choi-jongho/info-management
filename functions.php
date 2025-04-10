<?php
/**
 * Sanitize input data to prevent XSS attacks
 * 
 * @param string $data The input data to sanitize
 * @return string The sanitized data
 */
function sanitize_input($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data, ENT_QUOTES, 'UTF-8');
    return $data;
}

/**
 * Generate a formatted name with optional middle initial
 * 
 * @param string $first_name First name
 * @param string $last_name Last name
 * @param string $middle_name Middle name (optional)
 * @return string Formatted name
 */
function format_name($first_name, $last_name, $middle_name = '') {
    $formatted = "$first_name ";
    
    if (!empty($middle_name)) {
        $middle_initial = substr($middle_name, 0, 1);
        $formatted .= "$middle_initial. ";
    }
    
    $formatted .= $last_name;
    
    return $formatted;
}

/**
 * Format currency amount
 * 
 * @param float $amount The amount to format
 * @return string Formatted currency amount
 */
function format_currency($amount) {
    return '₱' . number_format($amount, 2);
}

/**
 * Get status badge HTML
 * 
 * @param string $status The status value
 * @return string HTML for the badge
 */
function get_status_badge($status) {
    $badge_class = '';
    $icon = '';
    
    switch ($status) {
        case 'Active':
            $badge_class = 'bg-success';
            $icon = 'check-circle';
            break;
        case 'Inactive':
            $badge_class = 'bg-danger';
            $icon = 'times-circle';
            break;
        default:
            $badge_class = 'bg-secondary';
            $icon = 'question-circle';
    }
    
    return '<span class="badge ' . $badge_class . '"><i class="fas fa-' . $icon . ' me-1"></i>' . $status . '</span>';
}

/**
 * Log user activities
 * 
 * @param string $action The action performed
 * @param string $description Description of the action
 * @param string $user_id ID of the user performing the action
 * @return bool True if log was created, false otherwise
 */

/**
 * Log user activities
 * 
 * @param string $action The action performed
 * @param string $description Description of the action
 * @param string $user_id ID of the user performing the action
 * @return bool True if log was created, false otherwise
 */
function log_activity($action, $description, $officer_id = 'system') {
    global $conn;

    // Check if officer_id exists in the officers table
    $stmt_check = $conn->prepare("SELECT COUNT(*) FROM officers WHERE officer_id = ?");
    $stmt_check->bind_param("s", $officer_id);
    $stmt_check->execute();
    $stmt_check->bind_result($count);
    $stmt_check->fetch();
    $stmt_check->close();

    if ($count > 0) {
        $action = sanitize_input($action);
        $description = sanitize_input($description);
        $user_id = sanitize_input($officer_id);

        $stmt = $conn->prepare("INSERT INTO activity_logs (officer_id, action, description) VALUES (?, ?, ?)");
        $stmt->bind_param("sss", $user_id, $action, $description);

        $result = $stmt->execute();
        $stmt->close();

        return $result;
    } else {
        // Optionally, you can log or handle this case where officer_id does not exist
        error_log("Attempted to log activity for non-existent officer_id: $officer_id");
        return false;
    }
}

    function delete_member($member_id, $officer_id) {
        global $conn;

        // Begin transaction
        $conn->begin_transaction();

        try {
            // Get the member data before deletion
            $stmt = $conn->prepare("SELECT * FROM members WHERE member_id = ?");
            $stmt->bind_param("s", $member_id);
            $stmt->execute();
            $result = $stmt->get_result();

            if ($result->num_rows === 0) {
                $conn->rollback();
                return false;  // Member not found
            }

            $member_data = $result->fetch_assoc();
            $member_name = $member_data['first_name'] . ' ' . $member_data['last_name'];
            $description = "Member {$member_name} (ID: {$member_id})";

            // Fetch fee data before deletion
            $fee_stmt = $conn->prepare("SELECT fee_type, fee_amount, semester, school_year, status FROM fees WHERE member_id = ?");
            $fee_stmt->bind_param("s", $member_id);
            $fee_stmt->execute();
            $fee_result = $fee_stmt->get_result();

            $fees = [];
            while ($fee_row = $fee_result->fetch_assoc()) {
                $fee_row['fee_type'] = strval($fee_row['fee_type']); // Ensure it's stored as a string
                $fees[] = $fee_row;
            }

            // Attach fees to member data
            $member_data['fees'] = $fees;
            $json_data = json_encode($member_data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);

            // Store in deleted_members table
            $json_data = json_encode($member_data);
            $store_stmt = $conn->prepare("
                INSERT INTO deleted_members (member_id, description, member_data, deleted_by) 
                VALUES (?, ?, ?, ?)
            ");
            $store_stmt->bind_param("ssss", $member_id, $description, $json_data, $officer_id);
            $store_stmt->execute();

            // Delete associated records in fees table
            $delete_fees_stmt = $conn->prepare("DELETE FROM fees WHERE member_id = ?");
            $delete_fees_stmt->bind_param("s", $member_id);
            $delete_fees_stmt->execute();

            // Delete from members table
            $delete_stmt = $conn->prepare("DELETE FROM members WHERE member_id = ?");
            $delete_stmt->bind_param("s", $member_id);
            $delete_stmt->execute();

            // Log the deletion
            log_activity(
                "Member Deletion", 
                "{$description} (Deleted by officer: {$officer_id})",
                $officer_id
            );

            $conn->commit();
            return true;
        } catch (Exception $e) {
            $conn->rollback();
            log_activity(
                "Error", 
                "Failed to delete member {$member_id}: " . $e->getMessage(),
                $officer_id
            );
            return false;
        }
    }
?>