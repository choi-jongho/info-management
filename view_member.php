<?php
    require_once('database.php');
    require_once('functions.php');

    // Check if ID is provided
    if (!isset($_GET['id']) || empty($_GET['id'])) {
        header("Location: members.php");
        exit();
    }

    $member_id = sanitize_input($_GET['id']);

    // Get member details along with total fee and semester count
    $stmt = $conn->prepare("
        SELECT 
            m.*, 
            COALESCE(SUM(f.fee_amount), 0) AS total_fee_amount,
            COUNT(f.semester) AS semester_count
        FROM members m
        LEFT JOIN fees f ON m.member_id = f.member_id
        WHERE m.member_id = ?
        GROUP BY m.member_id
    ");

    $stmt->bind_param("s", $member_id);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows === 0) {
        // Member not found, redirect to members page
        header("Location: members.php?error=notfound");
        exit();
    }

    $member = $result->fetch_assoc();
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
    <title>View Member | INTEL</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Custom Styles -->
    <link rel="stylesheet" href="css/style.css">
</head>
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
        a {
            color: #343434;
        }
</style>
<body>
    <!-- Header -->
    <?php include('navbar.php'); ?>

    <!-- Main Content -->
    <main class="container my-4">
        <div class="row mb-4">
            <div class="col-md-6">
                <h2><i class="fas fa-user me-2"></i>Member Details</h2>
            </div>
            <div class="col-md-6 text-md-end">
                <a href="members.php" class="btn btn-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Back to Members
                </a>
                </a>
                <?php if ($_SESSION['officer_role'] === 'intel_president'): ?>
                    <a href="edit_member.php?id=<?php echo urlencode($member_id); ?>" class="btn btn-warning">
                        <i class="fas fa-edit me-2"></i>Edit Member
                    </a>
                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal">
                        <i class="fas fa-trash me-2"></i>Delete
                    </button>
                <?php endif; ?>
            </div>
        </div>
        
        <div class="card shadow">
            <div class="card-header bg-navy text-white">
                <h4 class="mb-0">
                    <i class="fas fa-id-card me-2"></i><?php echo htmlspecialchars(format_name($member['first_name'], $member['last_name'], $member['middle_name'])); ?>
                    <span class="float-end"><?php echo get_status_badge($member['status']); ?></span>
                </h4>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <h5 class="border-bottom pb-2 mb-3">Personal Information</h5>
                        <div class="mb-3">
                            <label class="fw-bold">Member ID:</label>
                            <p><?php echo htmlspecialchars($member['member_id']); ?></p>
                        </div>
                        <div class="mb-3">
                            <label class="fw-bold">Full Name:</label>
                            <p><?php echo htmlspecialchars(format_name($member['first_name'], $member['last_name'], $member['middle_name'])); ?></p>
                        </div>
                        <div class="mb-3">
                            <label class="fw-bold">Last Name:</label>
                            <p><?php echo htmlspecialchars($member['last_name']); ?></p>
                        </div>
                        <div class="mb-3">
                            <label class="fw-bold">First Name:</label>
                            <p><?php echo htmlspecialchars($member['first_name']); ?></p>
                        </div>
                        <div class="mb-3">
                            <label class="fw-bold">Middle Name:</label>
                            <p><?php echo !empty($member['middle_name']) ? htmlspecialchars($member['middle_name']) : '<em>Not provided</em>'; ?></p>
                        </div>
                    </div>
                    
                    <div class="col-md-6">
                        <h5 class="border-bottom pb-2 mb-3">Contact Information</h5>
                        <div class="mb-3">
                            <label class="fw-bold">Email Address:</label>
                            <p>
                                <a href="mailto:<?php echo htmlspecialchars($member['email']); ?>" class="text-decoration-none">
                                    <i class="fas fa-envelope me-2"></i><?php echo htmlspecialchars($member['email']); ?>
                                </a>
                            </p>
                        </div>
                        <div class="mb-3">
                            <label class="fw-bold">Contact Number:</label>
                            <p>
                                <a href="tel:<?php echo htmlspecialchars($member['contact_num']); ?>" class="text-decoration-none">
                                    <i class="fas fa-phone me-2"></i><?php echo htmlspecialchars($member['contact_num']); ?>
                                </a>
                            </p>
                        </div>
                        
                        <h5 class="border-bottom pb-2 mb-3 mt-4">Membership Information</h5>
                        <div class="mb-3">
                            <label class="fw-bold">Status:</label>
                            <p><?php echo get_status_badge($member['status']); ?></p>
                        </div>
                        <div class="mb-3 d-flex justify-content-between align-items-center">
                        <div>
                            <label class="fw-bold me-2">Balance:</label>
                            <p class="<?php echo $member['total_fee_amount'] > 0 ? 'text-danger' : 'text-success'; ?>">
                                <?php echo format_currency($member['total_fee_amount']); ?>
                            </p>
                        </div>
                            <a href="breakdown.php?id=<?php echo urlencode($member_id); ?>" class="btn btn-info ms-auto">
                                <i class="fas fa-info-circle me-2"></i>View Breakdown
                            </a>
                        </div>
                        <div class="mb-3">
                            <label class="fw-bold">Semester:</label>
                            <p><?php echo htmlspecialchars($member['semester_count']); ?> semester(s)</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-footer bg-light">
                <div class="d-flex justify-content-end align-items-center">
                    <?php if ($_SESSION['officer_role'] === 'intel_president'): ?>
                        <a href="edit_member.php?id=<?php echo urlencode($member_id); ?>" class="btn btn-primary me-2">
                            <i class="fas fa-edit me-2"></i>Edit Information
                        </a>
                    <?php endif; ?>
                    <a href="payment_history.php?member_id=<?php echo urlencode($member_id); ?>" class="btn btn-outline-primary">
                        <i class="fas fa-money-bill-wave me-2"></i>View Payment History
                    </a>
                </div>
            </div>
        </div>
    </main>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title" id="deleteModalLabel">Confirm Deletion</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete this member?</p>
                    <p><strong>ID:</strong> <?php echo htmlspecialchars($member['member_id']); ?></p>
                    <p><strong>Name:</strong> <?php echo htmlspecialchars(format_name($member['first_name'], $member['last_name'], $member['middle_name'])); ?></p>
                    <div class="alert alert-warning">
                        <i class="fas fa-exclamation-triangle me-2"></i>This action cannot be undone.
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <a href="members.php?id=<?php echo urlencode($member_id); ?>&confirmDelete=1" class="btn btn-danger">
                        <i class="fas fa-trash me-2"></i>Delete
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <?php include('footer.php'); ?>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
