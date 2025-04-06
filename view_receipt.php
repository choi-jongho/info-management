<?php
    session_start();
    require_once('database.php');
    require_once('functions.php');

    // Check if officer is logged in
    $officer_id = $_SESSION['officer_id'] ?? null;
    if (!$officer_id) {
        header("Location: login.php");
        exit();
    }

    // Check if payment ID is provided
    if (!isset($_GET['payment_id']) || empty($_GET['payment_id'])) {
        header("Location: members.php?error=nopayment");
        exit();
    }

    $payment_id = sanitize_input($_GET['payment_id']);

    // Get receipt data
    $stmt = $conn->prepare("
        SELECT r.*, 
               m.first_name, 
               m.last_name, 
               o.officer_id,
               om.first_name as officer_first_name, 
               om.last_name as officer_last_name
        FROM receipts r
        JOIN members m ON r.member_id = m.member_id
        JOIN officers o ON r.officer_id = o.officer_id
        JOIN members om ON o.member_id = om.member_id
        WHERE r.payment_id = ?
    ");
    $stmt->bind_param("s", $payment_id);
    $stmt->execute();
    $receipt_result = $stmt->get_result();
    
    if ($receipt_result->num_rows === 0) {
        // No receipt found, check if payment exists
        $stmt->close();
        
        $stmt = $conn->prepare("SELECT p.*, m.first_name, m.last_name FROM payments p JOIN members m ON p.member_id = m.member_id WHERE p.payment_id = ?");
        $stmt->bind_param("s", $payment_id);
        $stmt->execute();
        $payment_result = $stmt->get_result();
        
        if ($payment_result->num_rows === 0) {
            // Payment not found
            header("Location: members.php?error=notfound");
            exit();
        }
        
        // Payment found but receipt not generated yet
        $payment = $payment_result->fetch_assoc();
        $stmt->close();
        
        // Get officer details - Fixed to join with members table
        $stmt = $conn->prepare("
            SELECT o.officer_id, m.first_name, m.last_name 
            FROM officers o
            JOIN members m ON o.member_id = m.member_id
            WHERE o.officer_id = ?
        ");
        $stmt->bind_param("s", $officer_id);
        $stmt->execute();
        $officer_result = $stmt->get_result();
        $officer = $officer_result->fetch_assoc();
        $stmt->close();
        
        // Create new receipt
        $receipt_id = uniqid('RCPT');
        
        // Insert into receipts table
        $stmt = $conn->prepare("INSERT INTO receipts (receipt_id, payment_id, member_id, officer_id, total_amount) VALUES (?, ?, ?, ?, ?)");
        $stmt->bind_param("ssssd", $receipt_id, $payment_id, $payment['member_id'], $officer_id, $payment['amount']);
        $stmt->execute();
        $stmt->close();
        
        // Create receipt data for display
        $receipt_data = [
            'receipt_id' => $receipt_id,
            'payment_date' => $payment['payment_date'],
            'member_id' => $payment['member_id'],
            'member_name' => $payment['first_name'] . ' ' . $payment['last_name'],
            'officer_name' => $officer['first_name'] . ' ' . $officer['last_name'],
            'payments' => [
                [
                    'payment_id' => $payment['payment_id'],
                    'semester' => $payment['semester'] ?? 'N/A',
                    'school_year' => $payment['school_year'] ?? 'N/A',
                    'amount' => $payment['amount']
                ]
            ]
        ];
    } else {
        // Receipt exists, get payment details
        $receipt = $receipt_result->fetch_assoc();
        $stmt->close();
        
        // Get payment details
        $stmt = $conn->prepare("SELECT * FROM payments WHERE payment_id = ?");
        $stmt->bind_param("s", $payment_id);
        $stmt->execute();
        $payment_result = $stmt->get_result();
        $payment = $payment_result->fetch_assoc();
        $stmt->close();
        
        // Create receipt data for display
        $receipt_data = [
            'receipt_id' => $receipt['receipt_id'],
            'payment_date' => $payment['payment_date'],
            'member_id' => $receipt['member_id'],
            'member_name' => $receipt['first_name'] . ' ' . $receipt['last_name'],
            'officer_name' => $receipt['officer_first_name'] . ' ' . $receipt['officer_last_name'],
            'payments' => [
                [
                    'payment_id' => $payment['payment_id'],
                    'semester' => $payment['semester'] ?? 'N/A',
                    'school_year' => $payment['school_year'] ?? 'N/A',
                    'amount' => $payment['amount']
                ]
            ]
        ];
    }
    
    // Store receipt data in session for display
    $_SESSION['receipt_data'] = $receipt_data;
    
    // Redirect to receipt page
    header("Location: payment_receipt.php");
    exit();
?>