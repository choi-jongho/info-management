<?php
    session_start();
    include('database.php'); // Include the database connection

    $search_query = isset($_GET['search']) ? trim($_GET['search']) : '';

    // Build the query
    $sql = "SELECT m.*, 
            (SELECT COALESCE(SUM(f.fee_amount), 0) FROM fees f WHERE f.member_id = m.member_id) AS total_fee_amount, 
            (SELECT COALESCE(COUNT(f.semester), 0) FROM fees f WHERE f.member_id = m.member_id) AS semester_count,
            (SELECT COUNT(DISTINCT semester) FROM fees) - (SELECT COUNT(DISTINCT semester) FROM fees WHERE member_id = m.member_id) AS missed_semesters,
            (SELECT COALESCE(SUM(f.fee_amount), 0) FROM fees f WHERE f.member_id = m.member_id AND f.status = 'Unpaid') AS total_unpaid_fees,
            (SELECT COUNT(f.semester) FROM fees f WHERE f.member_id = m.member_id AND f.status = 'Unpaid') AS unpaid_semester_count
            FROM members m 
            WHERE 1=1";

    // Parameters array for binding
    $params = array();
    $types = "";

    // Apply search filters with prepared statements
    if (!empty($search_query)) {
        $search_param = "%" . $search_query . "%";
        $sql .= " AND (m.member_id LIKE ? 
                    OR m.first_name LIKE ? 
                    OR m.last_name LIKE ? 
                    OR m.email LIKE ? 
                    OR m.contact_num LIKE ?)";
        
        // Add parameters 5 times for each LIKE condition
        $types .= "sssss";
        $params[] = $search_param;
        $params[] = $search_param;
        $params[] = $search_param;
        $params[] = $search_param;
        $params[] = $search_param;
    }

    // Group results properly
    $sql .= " GROUP BY m.member_id, m.first_name, m.last_name, m.email, m.contact_num, m.status";
    $sql .= " ORDER BY m.last_name ASC";

    // Prepare statement
    $stmt = $conn->prepare($sql);
    
    // Bind parameters dynamically
    if (!empty($params)) {
        // Create a reference array to pass to bind_param
        $bind_params = array();
        $bind_params[] = $types; // First parameter is the types string
        
        // Add references to each parameter
        for ($i = 0; $i < count($params); $i++) {
            $bind_params[] = &$params[$i];
        }
        
        // Call bind_param with the unpacked array
        call_user_func_array(array($stmt, 'bind_param'), $bind_params);
    }

    // Execute query
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()):
            $modal_id = 'delete_' . preg_replace('/[^a-zA-Z0-9]/', '_', $row['member_id']);
    ?>
            <!-- Rest of the code remains the same -->
                                <tr>
                                    <td><?php echo htmlspecialchars($row['member_id']); ?></td>
                                    <td>
                                        <?php 
                                            echo htmlspecialchars($row['last_name']) . ', ' . 
                                                htmlspecialchars($row['first_name']) . 
                                                (!empty($row['middle_name']) ? ' ' . htmlspecialchars($row['middle_name'][0]) . '.' : '');
                                        ?>
                                    </td>
                                    <td>
                                        <div><?php echo htmlspecialchars($row['email']); ?></div>
                                        <small class="text-muted"><?php echo htmlspecialchars($row['contact_num']); ?></small>
                                    </td>
                                    <td>
                                        <?php if ($row['total_unpaid_fees'] > 0): ?>
                                            <span class="text-danger">
                                                ₱<?php echo number_format($row['total_unpaid_fees'], 2); ?>
                                            </span>
                                        <?php else: ?>
                                            <span class="text-success">₱0.00</span>
                                        <?php endif; ?>
                                    </td>                                    
                                    <td>
                                        <?php
                                            $status_class = '';
                                            switch ($row['status']) {
                                                case 'Active':
                                                    $status_class = 'status-active';
                                                    break;
                                                case 'Inactive':
                                                    $status_class = 'status-inactive';
                                                    break;
                                                default:
                                                    $status_class = '';
                                            }
                                        ?>
                                        <span class="<?php echo $status_class; ?>">
                                            <?php echo htmlspecialchars($row['status']); ?>
                                        </span>
                                    </td>
                                    <td><?php echo htmlspecialchars($row['unpaid_semester_count']); ?> semester(s)</td>
                                    <td>
                                    <div class="action-buttons d-flex justify-content-center">
                                        <a href="view_member.php?id=<?php echo htmlspecialchars(urlencode($row['member_id'])); ?>" 
                                        class="btn btn-info text-white" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </a>

                                        <?php if (in_array($_SESSION['officer_role'], ['intel_president', 'intel_secretary'])): ?>
                                            <a href="edit_member.php?id=<?php echo htmlspecialchars(urlencode($row['member_id'])); ?>" 
                                            class="btn btn-warning text-white" title="Edit">
                                                <i class="fas fa-edit"></i>
                                            </a>

                                            <button type="button" class="btn btn-danger" data-bs-toggle="modal" 
                                                    data-bs-target="#delete_<?php echo htmlspecialchars($row['member_id']); ?>">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                        <?php endif; ?>
                                    </div>
                                        
                                        <!-- Delete Confirmation Modal -->
                                        <div class="modal fade" id="delete_<?php echo htmlspecialchars($row['member_id']); ?>" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header bg-danger text-white">
                                                        <h5 class="modal-title" id="deleteModalLabel">Confirm Deletion</h5>
                                                    </div>
                                                    <div class="modal-body">
                                                        <p>Are you sure you want to delete member <strong><?php echo htmlspecialchars($row['first_name'] . ' ' . $row['last_name']); ?></strong>?</p>
                                                        <p class="text-danger"><small>You can restore them in the activity logs.</small></p>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                        <a href="delete_member.php?id=<?php echo htmlspecialchars(urlencode($row['member_id'])); ?>" class="btn btn-danger">Delete</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
    <?php
        endwhile;
    } else {
        echo "<tr><td colspan='7' class='text-center text-muted'>No results found</td></tr>";
    }

    $stmt->close();
    $conn->close();
?>