<?php
    require_once('database.php');

    // Validation function
    function validate_fee_input($semester, $school_year, $fee_amount) {
        $errors = [];

        if (empty($semester)) {
            $errors[] = "Semester is required.";
        }
        if (empty($school_year)) {
            $errors[] = "School year is required.";
        }
        if (empty($fee_amount) || !is_numeric($fee_amount) || $fee_amount <= 0) {
            $errors[] = "Fee amount must be a positive number.";
        }

        return $errors;
    }

    // Logging function
    function log_fee_activity($action, $message, $officer_id) {
        global $conn;
        $stmt = $conn->prepare("INSERT INTO activity_logs (officer_id, action, message, log_time) VALUES (?, ?, ?, NOW())");
        $stmt->bind_param("sss", $officer_id, $action, $message);
        $stmt->execute();
        $stmt->close();
    }

    // Function to add fees for all members
    function add_fees_for_all_members($fee_type, $fee_amount, $semester, $school_year, $officer_id) {
        global $conn;
        $conn->begin_transaction();

        try {
            $stmt = $conn->prepare("
                INSERT INTO fees (member_id, fee_type, fee_amount, semester, school_year)
                SELECT member_id, ?, ?, ?, ? FROM members
            ");

            $stmt->bind_param("sdss", $fee_type, $fee_amount, $semester, $school_year);

            if ($stmt->execute()) {
                $conn->commit();
                log_fee_activity("Add Fees", "Added fee: $fee_type (₱$fee_amount) for Semester: $semester, SY: $school_year", $officer_id);
                return true;
            } else {
                throw new Exception("Error adding fees: " . $stmt->error);
            }

            $stmt->close();
        } catch (Exception $e) {
            $conn->rollback();
            return false;
        }
    }
?>