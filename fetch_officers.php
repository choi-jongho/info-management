<?php
    // fetch_officers.php - For AJAX search functionality

    // Start session
    session_start();
    $officer_id = $_SESSION['officer_id'] ?? null;

    if (!$officer_id) {
        echo "<tr><td colspan='6'>Authentication required</td></tr>";
        exit();
    }

    // Include database connection
    require_once('database.php');
    require_once('functions.php');

    // Get search term
    $search = isset($_GET['search']) ? trim($_GET['search']) : '';

    // Get current user's role for access control
    $current_role = $_SESSION['officer_role'] ?? 'intel_member';
    
    // Only intel_president and intel_secretary can edit and delete (changed from previous version)
    $is_officer = in_array($current_role, ['intel_president', 'intel_secretary']);

    // Search query
    $query = "SELECT o.member_id, o.role_id,
                    m.first_name, m.last_name,
                    r.role_name 
            FROM officers o 
            JOIN members m ON o.member_id = m.member_id 
            JOIN role r ON o.role_id = r.role_id
            WHERE m.first_name LIKE ? OR m.last_name LIKE ? OR r.role_name LIKE ?
                    OR o.member_id LIKE ?
            ORDER BY o.role_id";

    $stmt = $conn->prepare($query);
    $search_param = "%$search%";
    $stmt->bind_param("ssss", $search_param, $search_param, $search_param, $search_param);
    $stmt->execute();
    $result = $stmt->get_result();

    // Generate HTML for search results
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $modal_id = 'delete_' . preg_replace('/[^a-zA-Z0-9]/', '_', $row['officer_id']);
            
            echo "<tr>
                <td>" . htmlspecialchars($row['member_id']) . "</td>
                <td>" . htmlspecialchars($row['first_name'] . ' ' . $row['last_name']) . "</td>
                <td>" . htmlspecialchars($row['role_name']) . "</td>
                <td>
                    <div class='action-buttons d-flex justify-content-center'>
                        <a href='view_officer.php?id=" . htmlspecialchars($row['officer_id']) . "' 
                            class='btn btn-info text-white' title='View Details'>
                            <i class='fas fa-eye'></i>
                        </a>";
            
            // Only show edit and delete buttons for authorized officers
            if ($is_officer) {
                echo "<a href='edit_officer.php?id=" . htmlspecialchars($row['officer_id']) . "' 
                        class='btn btn-warning text-white' title='Edit'>
                        <i class='fas fa-edit'></i>
                    </a>
                    
                    <button type='button' class='btn btn-danger' data-bs-toggle='modal' 
                            data-bs-target='#{$modal_id}' title='Delete'>
                        <i class='fas fa-trash-alt'></i>
                    </button>";
            }
            
            echo "</div>";
            
            // Only add the modal for authorized officers
            if ($is_officer) {
                echo "<div class='modal fade' id='{$modal_id}' tabindex='-1' aria-labelledby='deleteModalLabel' aria-hidden='true'>
                    <div class='modal-dialog'>
                        <div class='modal-content'>
                            <div class='modal-header bg-danger text-white'>
                                <h5 class='modal-title' id='deleteModalLabel'>Confirm Deletion</h5>
                                <button type='button' class='btn-close' data-bs-dismiss='modal' aria-label='Close'></button>
                            </div>
                            <div class='modal-body'>
                                <p>Are you sure you want to delete officer <strong>" . htmlspecialchars($row['first_name'] . ' ' . $row['last_name']) . "</strong>?</p>
                                <p class='text-danger'><small>This action cannot be undone.</small></p>
                            </div>
                            <div class='modal-footer'>
                                <button type='button' class='btn btn-secondary' data-bs-dismiss='modal'>Cancel</button>
                                <a href='officer_list.php?action=delete&id=" . htmlspecialchars($row['officer_id']) . "' class='btn btn-danger'>Delete</a>
                            </div>
                        </div>
                    </div>
                </div>";
            }
            
            echo "</td>
            </tr>";
        }
    } else {
        echo "<tr><td colspan='5' class='text-center'>No officers found matching '{$search}'</td></tr>";
    }

    $stmt->close();
    $conn->close();
?>