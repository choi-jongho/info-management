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
?>