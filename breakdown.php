<?php
    require_once('database.php');
    require_once('functions.php');

    // Start the session and check if the officer is logged in
    session_start();
    $officer_id = $_SESSION['officer_id'] ?? null;
    $officer_role = $_SESSION['officer_role'] ?? null;

    if (!$officer_id) {
        header("Location: login.php");
        exit();
    }

    // Check if the member ID is provided
    if (!isset($_GET['id']) || empty($_GET['id'])) {
        header("Location: members.php");
        exit();
    }

    $member_id = sanitize_input($_GET['id']);

    // Fetch member details along with total fee and semester list
    $stmt = $conn->prepare("
        SELECT 
            m.member_id, 
            m.first_name, 
            m.last_name, 
            m.middle_name,
            m.email, 
            m.contact_num, 
            m.status,
            COALESCE(SUM(f.fee_amount), 0) AS total_fee_amount, 
            COUNT(f.semester) AS semesters
        FROM members m
        LEFT JOIN fees f ON m.member_id = f.member_id
        WHERE m.member_id = ?
        GROUP BY m.member_id
    ");

    $stmt->bind_param("s", $member_id);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows === 0) {
        header("Location: members.php?error=notfound");
        exit();
    }

    $member = $result->fetch_assoc();
    $stmt->close();

    // Fetch semester-wise breakdown of fee payments - now including status
    $stmt = $conn->prepare("
        SELECT f.semester, f.fee_amount, f.fee_type, f.school_year, f.status
        FROM fees f
        WHERE f.member_id = ?
        ORDER BY f.school_year DESC, f.semester ASC
    ");

    $stmt->bind_param("s", $member_id);
    $stmt->execute();
    $fees_result = $stmt->get_result();
    $fees = $fees_result->fetch_all(MYSQLI_ASSOC);
    $stmt->close();

    // Create breakdown array including `fee_type`, `school_year`, and `status`
    $breakdown = [];
    foreach ($fees as $row) {
        $breakdown[] = [
            'school_year' => htmlspecialchars($row['school_year']),
            'semester' => htmlspecialchars($row['semester']),
            'fee_type' => htmlspecialchars($row['fee_type']),
            'amount' => number_format($row['fee_amount'], 2),
            'status' => htmlspecialchars($row['status'])
        ];
    }
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pending Payment Breakdown | INTEL</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
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
        footer {
            background-color: #001f3f; /* Navy background */
            color: white;
            text-align: center;
            padding: 10px 0;
        }
        .status-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            padding: 5px 10px;
            border-radius: 5px;
            font-weight: bold;
        }
        .status-paid {
            background-color: #28a745;
            color: white;
        }
        .status-unpaid {
            background-color: #dc3545;
            color: white;
        }
        .fee-card {
            position: relative;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <?php include('navbar.php'); ?>
    <main class="container my-5">
        <div class="card shadow">
            <div class="card-header bg-navy text-white">
                <h3>Pending Payment Breakdown</h3>
            </div>
            <div class="card-body">
                <p><strong>Member ID:</strong> <?php echo htmlspecialchars($member['member_id']); ?></p>
                <p><strong>Name:</strong> <?php echo htmlspecialchars(format_name($member['first_name'], $member['last_name'], $member['middle_name'])); ?></p>
                <p><strong>Balance:</strong> <?php echo htmlspecialchars($member['total_fee_amount']); ?> PHP</p>
                <p><strong>Semester(s):</strong> <?php echo htmlspecialchars($member['semesters']); ?></p>

                <h5 class="mt-4">Breakdown:</h5>
                <div class="container">
                    <?php 
                    // Group fees by school year
                    $grouped_fees = [];
                    foreach ($breakdown as $item) {
                        $grouped_fees[$item['school_year']][] = $item;
                    }
                    ?>

                    <?php foreach ($grouped_fees as $school_year => $fees): ?>
                        <div class="card mb-3">
                            <div class="card-header bg-navy text-white">
                                <strong>School Year: <?php echo htmlspecialchars($school_year); ?></strong>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <?php foreach ($fees as $fee): ?>
                                        <div class="col-md-6">
                                            <div class="p-3 border rounded fee-card">
                                                <div class="status-badge <?php echo $fee['status'] === 'Paid' ? 'status-paid' : 'status-unpaid'; ?>">
                                                    <?php echo htmlspecialchars($fee['status']); ?>
                                                </div>
                                                <strong>Semester:</strong> <?php echo htmlspecialchars($fee['semester']); ?><br>
                                                <strong>Fee Type:</strong> <?php echo htmlspecialchars($fee['fee_type']); ?><br>
                                                <strong>Amount:</strong> ₱<?php echo htmlspecialchars($fee['amount']); ?>
                                            </div>
                                        </div>
                                    <?php endforeach; ?>
                                </div>
                            </div>
                        </div>
                    <?php endforeach; ?>
                </div>
            </div>
        </div>
        <div class="d-flex justify-content-between mt-4">
            <a href="members.php" class="btn btn-secondary me-2">
                <i class="fas fa-times me-1"></i> Cancel
            </a>
            <?php if (in_array($_SESSION['officer_role'], ['intel_treasurer', 'intel_president'])): ?>
                <a href="add_payments.php" class="btn btn-success me-2">
                    <i class="fas fa-money-bill-wave me-1"></i> Add Payment
                </a>
            <?php endif; ?>
        </div>
    </main>
    <?php include('footer.php'); ?>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>