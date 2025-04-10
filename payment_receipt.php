<?php
    session_start();
    
    // Ensure receipt data exists
    if (!isset($_SESSION['receipt_data'])) {
        header("Location: members.php");
        exit();
    }

    
    $receipt = $_SESSION['receipt_data'];
    $receipt_id = $receipt['receipt_id'] ?? uniqid('RCPT');
    $total_amount = 0;
    
    // Calculate total
    foreach ($receipt['payments'] as $payment) {
        $total_amount += $payment['amount'];
    }
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Receipt</title>
    <link rel="icon" href="images/info-tech.svg">
    <style>
        .receipt-container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ddd;
            font-family: Arial, sans-serif;
        }
        .receipt-header {
            text-align: center;
            margin-bottom: 20px;
            border-bottom: 2px solid #333;
            padding-bottom: 10px;
        }
        .receipt-header h1 {
            margin: 0;
            color: #333;
        }
        .receipt-details {
            margin-bottom: 20px;
        }
        .receipt-details table {
            width: 100%;
        }
        .receipt-details td {
            padding: 5px;
        }
        .receipt-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .receipt-table th, .receipt-table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        .receipt-table th {
            background-color: #f2f2f2;
        }
        .receipt-footer {
            margin-top: 30px;
            text-align: center;
            font-size: 14px;
        }
        .receipt-total {
            font-weight: bold;
            text-align: right;
            margin: 15px 0;
            font-size: 18px;
        }
        .receipt-signature {
            margin-top: 50px;
            display: flex;
            justify-content: space-between;
        }
        .signature-line {
            width: 200px;
            border-top: 1.5px solid #333;
            margin-top: 10px;
            text-align: center;
            padding-top: 5px;
        }
        .receipt-actions {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px dashed #ddd;
        }
        .receipt-actions button {
            padding: 10px 20px;
            margin: 0 10px;
            cursor: pointer;
        }
        .logo-container {
            display: flex;
            align-items: start;
            justify-content: space-between;
            margin-bottom: 10px;
            padding: 0 40px;
        }

        .left-logo, .right-logo {
            width: 100px;
            height: auto;
            margin-top: 30px;
        }

        .receipt-title {
            flex: 1;
            text-align: center;
        }

        @media print {
            .receipt-actions {
                display: none;
            }
            body {
                margin: 0;
                padding: 0;
            }
            .left-logo, .right-logo {
                max-width: 90px;
            }
        }
    </style>
</head>
<body>
    <div class="receipt-container">
        <div class="receipt-header">
            <div class="logo-container">
                <img src="images/0g.png" alt="Left Logo" class="left-logo">
                <div class="receipt-title">
                    <h1>PAYMENT RECEIPT</h1>
                    <p>Information Technology Link</p>
                    <p>Arch. Lino R. Gonzaga Ave. Tacloban City, Leyte</p>
                    <p>Email: evsu.intel@evsu.edu.ph</p>
                </div>
                <img src="images/intel.png" alt="Right Logo" class="right-logo">
            </div>
        </div>
        
        <div class="receipt-details">
            <table>
                <tr>
                    <td><strong>Receipt No:</strong> <?php echo $receipt_id; ?></td>
                    <td><strong>Date:</strong> <?php echo date('F d, Y', strtotime($receipt['payment_date'])); ?></td>
                </tr>
                <tr>
                    <td><strong>Member ID:</strong> <?php echo $receipt['member_id']; ?></td>
                    <td><strong>Time:</strong> <?php echo date('h:i A', strtotime($receipt['payment_date'])); ?></td>
                </tr>
                <tr>
                    <td><strong>Member Name:</strong> <?php echo $receipt['member_name']; ?></td>
                    <td></td>
                </tr>
            </table>
        </div>
        
        <table class="receipt-table">
            <thead>
                <tr>
                    <th>Payment ID</th>
                    <th>Semester</th>
                    <th>School Year</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($receipt['payments'] as $payment): ?>
                <tr>
                    <td><?php echo $payment['payment_id']; ?></td>
                    <td><?php echo $payment['semester']; ?></td>
                    <td><?php echo $payment['school_year']; ?></td>
                    <td>₱<?php echo number_format($payment['amount'], 2); ?></td>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
        
        <div class="receipt-total">
            Total Amount Paid: ₱<?php echo number_format($total_amount, 2); ?>
        </div>
        
        <div class="receipt-signature">
            <div class="signature-line">
                <?php echo $receipt['member_name']; ?><br>
                Member
            </div>
            <div>
                <div class="signature-line">
                    <?php echo $receipt['officer_name']; ?><br>
                    INTEL <?php echo $receipt['officer_role'] ?? 'Officer'; ?>
                </div>
            </div>
        </div>
        
        <div class="receipt-footer">
            <p>Thank you for your payment! This is an official receipt for your records.</p>
            <p>Please keep this receipt for future reference.</p>
        </div>
        
        <div class="receipt-actions">
            <button onclick="window.print()">Print Receipt</button>
            <button onclick="window.location.href='members.php'">Return to Members</button>
        </div>
    </div>
</body>
</html>

<?php
    unset($_SESSION['receipt_data']);
?>