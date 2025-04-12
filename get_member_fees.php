<?php
    require_once('database.php');
    require_once('functions.php');

    // Get member_id from request
    $member_id = sanitize_input($_GET['member_id'] ?? '');

    // Initialize response
    $response = [];

    if (empty($member_id)) {
        $response['error'] = 'Student ID is required';
        echo json_encode($response);
        exit;
    }

    // Check database connection
    if ($conn->connect_error) {
        $response['error'] = 'Database connection failed: ' . $conn->connect_error;
        echo json_encode($response);
        exit;
    }

    try {
        $stmt = $conn->prepare("SELECT member_id, CONCAT(first_name, ' ', last_name) AS member_name FROM members WHERE member_id = ?");
        if (!$stmt) {
            throw new Exception("Prepare failed: " . $conn->error);
        }
        
        $stmt->bind_param("s", $member_id);
        $result = $stmt->execute();
        
        if (!$result) {
            throw new Exception("Execute failed: " . $stmt->error);
        }
        
        $result = $stmt->get_result();
        
        if ($result->num_rows === 0) {
            $response['error'] = 'Member not found';
            echo json_encode($response);
            exit;
        }
        
        $member = $result->fetch_assoc();
        $stmt->close();
        
        // Get outstanding fees for the member
        $fees_query = $conn->prepare("SELECT member_id, fee_amount, fee_type, semester, school_year, status FROM fees WHERE member_id = ? AND status = 'Unpaid'");
        if (!$fees_query) {
            throw new Exception("Fee query prepare failed: " . $conn->error);
        }
        
        $fees_query->bind_param("s", $member_id);
        if (!$fees_query->execute()) {
            throw new Exception("Fee query execute failed: " . $fees_query->error);
        }
        
        $fees_result = $fees_query->get_result();
        $fees = [];
        
        while ($fee = $fees_result->fetch_assoc()) {
            // Ensure fee_type is never null
            if (empty($fee['fee_type'])) {
                $fee['fee_type'] = 'Membership Fee'; // Default value
            }
            $fees[] = $fee;
        }
        
        $fees_query->close();
        
        // Prepare response
        $response = [
            'member_id' => $member['member_id'],
            'member_name' => $member['member_name'],
            'fees' => $fees,
            'fees_count' => count($fees)
        ];
        
        echo json_encode($response);
        exit;
        
    } catch (Exception $e) {
        $response['error'] = 'Error: ' . $e->getMessage();
        echo json_encode($response);
        exit;
    }
?>