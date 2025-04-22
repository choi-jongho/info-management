<?php
    session_start();

    // Check if officer is logged in
    $officer_id = $_SESSION['officer_id'] ?? null;
    if (!$officer_id) {
        // Officer not logged in, redirect to login page
        header("Location: login.php");
        exit();
    }
    require_once('database.php');
    require_once('functions.php');

    // Check if member ID is provided
    if (!isset($_GET['member_id']) || empty($_GET['member_id'])) {
        header("Location: members.php?error=notfound");
        exit();
    }

    $member_id = sanitize_input($_GET['member_id']);

    // Get member details
    $stmt = $conn->prepare("SELECT first_name, last_name FROM members WHERE member_id = ?");
    $stmt->bind_param("s", $member_id);
    $stmt->execute();
    $member_result = $stmt->get_result();

    if ($member_result->num_rows === 0) {
        // Member not found, redirect to members page
        header("Location: members.php?error=notfound");
        exit();
    }

    $member = $member_result->fetch_assoc();
    $stmt->close();

    // Get payment history for the member
    $stmt = $conn->prepare("SELECT * FROM payments WHERE member_id = ? ORDER BY payment_date DESC");
    $stmt->bind_param("s", $member_id);
    $stmt->execute();
    $payments_result = $stmt->get_result();
    $payments = $payments_result->fetch_all(MYSQLI_ASSOC);
    $stmt->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment History | INTEL</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="icon" href="images/info-tech.svg">
    <style>
        html, body {
            height: 100%;
            margin: 0;
            display: flex;
            flex-direction: column;
            background-color: #f8f9fa;
        }
        main {
            flex: 1;
        }
        .bg-navy {
            background-color: #001f3f !important;
        }
        .text-white {
            color: #ffffff !important;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <?php include('navbar.php'); ?>

    <!-- Main Content -->
    <main class="container my-4">
        <div class="row mb-4">
            <div class="col-md-6">
                <h2><i class="fas fa-money-bill-wave me-2"></i>Payment History</h2>
            </div>
            <div class="col-md-6 text-md-end">
                <a href="members.php" class="btn btn-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Back to Members
                </a>
            </div>
        </div>
        
        <div class="card shadow">
            <div class="card-header bg-navy text-white">
                <h4 class="mb-0">
                    <i class="fas fa-id-card me-2"></i>Payment History for Member: <?php echo htmlspecialchars($member['first_name'] . ' ' . $member['last_name']); ?>
                </h4>
            </div>
            <div class="card-body">
                <h5 class="border-bottom pb-2 mb-3 mt-4">Payment History</h5>
                <?php if (count($payments) > 0): ?>
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>Payment ID</th>
                                    <th>Fee Type</th>
                                    <th>Amount</th>
                                    <th>Semester</th>
                                    <th>School Year</th>
                                    <th>Payment Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($payments as $payment): ?>
                                    <tr>
                                        <td><?php echo htmlspecialchars($payment['payment_id']); ?></td>
                                        <td><?php echo htmlspecialchars($payment['fee_type']); ?></td>
                                        <td><?php echo format_currency($payment['amount']); ?></td>
                                        <td><?php echo htmlspecialchars($payment['semester']); ?></td>
                                        <td><?php echo htmlspecialchars($payment['school_year']); ?></td>
                                        <td><?php echo htmlspecialchars($payment['payment_date']); ?></td>
                                            <?php if (in_array($_SESSION['officer_role'], ['intel_treasurer', 'intel_president'])): ?>
                                                <td class="text-end">
                                                    <a href="view_receipt.php?payment_id=<?php echo htmlspecialchars(urlencode($payment['payment_id'])); ?>" class="btn btn-sm btn-primary">
                                                        <i class="fas fa-file-invoice me-1"></i>View Receipt
                                                    </a>
                                                </td>
                                            <?php endif; ?>
                                        </tr>
                                    <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                <?php else: ?>
                    <p>No payment records found for this member.</p>
                <?php endif; ?>
            </div>
            <div class="card-footer bg-light">
                <div class="d-flex justify-content-between align-items-center">
                <a href="view_member.php?id=<?php echo htmlspecialchars(urlencode($member_id)); ?>" class="btn btn-primary">
                        <i class="fas fa-arrow-left me-2"></i>Back to Member Details
                    </a>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <?php include('footer.php'); ?>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
