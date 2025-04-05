
<?php
    // Get current page filename
    $current_page = basename($_SERVER['PHP_SELF']);

    // Start session if not already started
    if (session_status() == PHP_SESSION_NONE) {
        session_start();
    }

    // Get session info for user display
    $user_name = $_SESSION['username'] ?? 'Admin';
    $user_role = $_SESSION['role_id'] ?? 'Administrator';
?>

<!--- Navigation Bar --->
<header>
    <nav class="navbar navbar-expand-lg navbar-dark bg-navy shadow">
        <div class="container">
            <!-- Logo and Brand -->
            <a class="navbar-brand d-flex align-items-center me-5" href="dashboard.php">
                <i class="fas fa-laptop-code me-3"></i>
                <span>Information Technology Link</span>
            </a>

            <!-- Mobile Toggle Button -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain" 
                    aria-controls="navbarMain" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Navigation Items -->
            <div class="collapse navbar-collapse ms-5" id="navbarMain">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item me-5">
                        <a class="nav-link <?php echo ($current_page == 'dashboard.php') ? 'active' : ''; ?>" href="dashboard.php">
                            <i class="fas fa-home me-1"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item dropdown me-5">
                        <a class="nav-link dropdown-toggle <?php echo (in_array($current_page, ['members.php', 'add_member.php', 'edit_member.php', 'view_member.php'])) ? 'active' : ''; ?>" 
                           href="#" id="membersDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-users me-1"></i> Members
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="membersDropdown">
                            <li>
                                <a class="dropdown-item" href="members.php">
                                    <i class="fas fa-list me-2"></i> All Members
                                </a>
                            </li>
                            <?php if (in_array($_SESSION['officer_role'], ['intel_treasurer', 'intel_president'])): ?>
                                <li>
                                    <a class="dropdown-item" href="add_member.php">
                                        <i class="fas fa-user-plus me-2"></i> Add New Member
                                    </a>
                                </li>
                            <?php endif; ?>
                        </ul>
                    </li>

                    <li class="nav-item dropdown me-5">
                        <a class="nav-link dropdown-toggle <?php echo (in_array($current_page, ['payments.php', 'add_payment.php', 'payment_history.php'])) ? 'active' : ''; ?>" 
                           href="#" id="paymentsDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-money-bill-wave me-1"></i> Payments
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="paymentsDropdown">
                            <li>
                                <a class="dropdown-item" href="payments.php">
                                    <i class="fas fa-list me-2"></i> All Payments
                                </a>
                            </li>
                            <?php if (in_array($_SESSION['officer_role'], ['intel_treasurer', 'intel_president'])): ?>
                                <li>
                                    <a class="dropdown-item" href="add_payments.php">
                                        <i class="fas fa-plus-circle me-2"></i> Record Payment
                                    </a>
                                </li>
                            <?php endif; ?>
                        </ul>
                    </li>
                </ul>

                <!-- User Profile Dropdown -->
                <ul class="navbar-nav">
                    <li class="nav-item dropdown ms-0">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-user-circle me-1"></i> <?php echo htmlspecialchars($user_name); ?>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                            <li class="dropdown-item-text text-muted ps-2">
                                <small>Signed in as</small><br>
                                <span class="fw-bold"><?php echo htmlspecialchars($user_name); ?></span>
                            </li>
                            <li><hr class="dropdown-divider"></li>

                            <?php if ($_SESSION['officer_role'] === 'intel_president'): ?>
                                <li>
                                    <a class="dropdown-item" href="new_officer.php">
                                        <i class="fas fa-user-plus me-2"></i> Add New Officer
                                    </a>
                                </li>
                            <?php endif; ?>

                            <li>
                                <a class="dropdown-item" href="profile.php">
                                    <i class="fas fa-id-card me-2"></i> My Profile
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item" href="settings.php">
                                    <i class="fas fa-cog me-2"></i> Settings
                                </a>
                            </li>
                            <?php if ($_SESSION['officer_role'] === 'intel_president'): ?>
                                <li>
                                    <a class="dropdown-item" href="activity_log.php">
                                        <i class="fas fa-history me-2"></i> Activity Log
                                    </a>
                                </li>
                            <?php endif; ?>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <a class="dropdown-item text-danger" href="logout.php">
                                    <i class="fas fa-sign-out-alt me-2"></i> Logout
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</header>