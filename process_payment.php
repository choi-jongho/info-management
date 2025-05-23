<?php
    // In the file where you process payments (likely process_payment.php)
    // After a payment is processed successfully:

    $receipt_id = uniqid('RCPT');
    $total_amount = $payment_amount; // Or the sum of multiple payments if applicable

    // Insert into receipts table
    $stmt = $conn->prepare("INSERT INTO receipts (receipt_id, payment_id, member_id, officer_id, total_amount) 
                            VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param("ssssd", $receipt_id, $payment_id, $member_id, $officer_id, $total_amount);
    $stmt->execute();
    $stmt->close();

    // Store receipt data in session for immediate display
    $_SESSION['receipt_data'] = [
        'receipt_id' => $receipt_id,
        'payment_date' => $payment_date,
        'member_id' => $member_id,
        'member_name' => $member_name,
        'officer_name' => $officer_name,
        'officer_role' => $role_name,  // Add this line
        'payments' => $payments
    ];

    // Redirect to receipt page
    header("Location: payment_receipt.php");
    exit();
?>