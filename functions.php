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
     * @param string $officer_id ID of the user performing the action
     * @return bool True if log was created, false otherwise
     */
    function log_activity($action, $description, $officer_id = 'system') {
        global $conn;

        if (empty($officer_id)) {
            return false; // Invalid officer ID
        }

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

    /**
     * Delete a member from the system and store the data in deleted_members table
     * 
     * @param string $member_id ID of the member to delete
     * @param string $officer_id ID of the officer performing the action
     * @return bool True if deletion was successful, false otherwise
     */
    function delete_member($member_id, $officer_id) {
        global $conn;
    
        if (empty($officer_id)) {
            error_log("Invalid officer ID: $officer_id");
            return false;
        }
    
        $conn->begin_transaction();
    
        try {
            $check_deleted_stmt = $conn->prepare("SELECT 1 FROM deleted_members WHERE member_id = ?");
            $check_deleted_stmt->bind_param("s", $member_id);
            $check_deleted_stmt->execute();
            $check_deleted_stmt->store_result();
    
            if ($check_deleted_stmt->num_rows > 0) {
                $check_deleted_stmt->close();
                $conn->rollback();
                return false; // Already archived
            }
            $check_deleted_stmt->close();
    
            // Fetch member info
            $stmt = $conn->prepare("SELECT * FROM members WHERE member_id = ?");
            $stmt->bind_param("s", $member_id);
            $stmt->execute();
            $result = $stmt->get_result();
    
            if ($result->num_rows === 0) {
                $conn->rollback();
                return false;
            }
    
            $member_data = $result->fetch_assoc();
            $member_name = $member_data['first_name'] . ' ' . $member_data['last_name'];
            $description = "Member {$member_name} (ID: {$member_id})";
    
            // Fetch fees
            $stmt_fees = $conn->prepare("SELECT * FROM fees WHERE member_id = ?");
            $stmt_fees->bind_param("s", $member_id);
            $stmt_fees->execute();
            $fees_result = $stmt_fees->get_result();
            $fees_data = [];
            while ($fee = $fees_result->fetch_assoc()) {
                $fees_data[] = $fee;
            }
    
            // Fetch payments
            $stmt_payments = $conn->prepare("SELECT * FROM payments WHERE member_id = ?");
            $stmt_payments->bind_param("s", $member_id);
            $stmt_payments->execute();
            $payments_result = $stmt_payments->get_result();
            $payments_data = [];
            while ($payment = $payments_result->fetch_assoc()) {
                $payments_data[] = $payment;
            }
    
            // Fetch receipts
            $stmt_receipts = $conn->prepare("SELECT * FROM receipts WHERE member_id = ?");
            $stmt_receipts->bind_param("s", $member_id);
            $stmt_receipts->execute();
            $receipts_result = $stmt_receipts->get_result();
            $receipts_data = [];
            while ($receipt = $receipts_result->fetch_assoc()) {
                $receipts_data[] = $receipt;
            }
    
            // Convert all to JSON
            $json_member_data = json_encode($member_data);
            $json_fees_data = json_encode($fees_data);
            $json_payments_data = json_encode($payments_data);
            $json_receipts_data = json_encode($receipts_data);
    
            // Store in deleted_members
            $store_stmt = $conn->prepare("
                INSERT INTO deleted_members 
                (member_id, description, member_data, fees_data, payments_data, receipts_data, deleted_by) 
                VALUES (?, ?, ?, ?, ?, ?, ?)
            ");
            $store_stmt->bind_param(
                "sssssss",
                $member_id,
                $description,
                $json_member_data,
                $json_fees_data,
                $json_payments_data,
                $json_receipts_data,
                $officer_id
            );
            $store_stmt->execute();
    
            // Delete from source tables
            $delete_members = $conn->prepare("DELETE FROM members WHERE member_id = ?");
            $delete_members->bind_param("s", $member_id);
            $delete_members->execute();
    
            $delete_fees = $conn->prepare("DELETE FROM fees WHERE member_id = ?");
            $delete_fees->bind_param("s", $member_id);
            $delete_fees->execute();
    
            $delete_payments = $conn->prepare("DELETE FROM payments WHERE member_id = ?");
            $delete_payments->bind_param("s", $member_id);
            $delete_payments->execute();
    
            $delete_receipts = $conn->prepare("DELETE FROM receipts WHERE member_id = ?");
            $delete_receipts->bind_param("s", $member_id);
            $delete_receipts->execute();
    
            // Log action
            log_activity(
                "Member Deletion",
                "{$description} (Deleted by officer: {$officer_id})",
                $officer_id
            );
    
            $conn->commit();
            return true;
        } catch (Exception $e) {
            $conn->rollback();
            log_activity("Error", "Failed to delete member {$member_id}: " . $e->getMessage(), $officer_id);
            return false;
        }
    }
    
?>
