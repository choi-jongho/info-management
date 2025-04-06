<?php
    session_start();
    include('database.php'); // Include the database connection

    $search_query = isset($_GET['search']) ? trim($_GET['search']) : '';

    $sql = "SELECT m.*, 
        (SELECT COALESCE(SUM(f.fee_amount), 0) FROM fees f WHERE f.member_id = m.member_id) AS total_fee_amount, 
        (SELECT COALESCE(COUNT(f.semester), 0) FROM fees f WHERE f.member_id = m.member_id) AS semester_count 
        FROM members m";

    if (!empty($search_query)) {
    $sql .= " WHERE m.member_id LIKE ? 
            OR m.first_name LIKE ? 
            OR m.last_name LIKE ? 
            OR m.email LIKE ? 
            OR m.contact_num LIKE ? 
            OR m.status LIKE ?";
    }

    $stmt = $conn->prepare($sql);

    if (!empty($search_query)) {
        $search_param = "%" . $search_query . "%";
        $stmt->bind_param("ssssss", $search_param, $search_param, $search_param, $search_param, $search_param, $search_param);
    }

    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()):
            $modal_id = 'delete_' . preg_replace('/[^a-zA-Z0-9]/', '_', $row['member_id']);
    ?>
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
                    <?php
                        $status_class = ($row['status'] === 'Active') ? 'status-active' : 'status-inactive';
                    ?>
                    <span class="<?php echo $status_class; ?>">
                        <?php echo htmlspecialchars($row['status']); ?>
                    </span>
                </td>
                <td>₱<?php echo number_format($row['total_fee_amount'] ?? 0, 2); ?></td>
                <td><?php echo htmlspecialchars($row['semester_count'] ?? 'N/A'); ?> semester(s)</td>
                <td>
                    <div class="action-buttons d-flex justify-content-center">
                        <a href="view_member.php?id=<?php echo htmlspecialchars(urlencode($row['member_id'])); ?>" 
                        class="btn btn-info text-white" title="View Details">
                            <i class="fas fa-eye"></i>
                        </a>

                        <?php if (isset($_SESSION['officer_role']) && in_array($_SESSION['officer_role'], ['intel_treasurer', 'intel_president'])): ?>
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
                                    <p class="text-danger"><small>This action cannot be undone.</small></p>
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