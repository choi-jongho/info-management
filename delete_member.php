<?php
    // Start session
    session_start();
    $officer_id = $_SESSION['officer_id'] ?? null;

    if (!$officer_id) {
        header("Location: login.php");
        exit();
    }

    // Include database connection
    require_once('database.php');
    require_once('functions.php');

    // Get the member ID from URL
    $member_id = $_GET['id'] ?? null;

    if (!$member_id) {
        $_SESSION['warning_message'] = "No member ID provided for deletion.";
        header("Location: members.php");
        exit();
    }

    // First check if the member is an officer
    $check_officer_stmt = $conn->prepare("
        SELECT o.officer_id 
        FROM officers o 
        JOIN members m ON o.member_id = m.member_id 
        WHERE m.member_id = ?
    ");
    $check_officer_stmt->bind_param("s", $member_id);
    $check_officer_stmt->execute();
    $officer_result = $check_officer_stmt->get_result();

    if ($officer_result->num_rows > 0) {
        // Member is an officer, cannot delete
        $_SESSION['warning_message'] = "Cannot delete this member as they are currently an officer. Remove them from the officers list first.";
        header("Location: members.php");
        exit();
    }

    // If not an officer, proceed with deletion
    // Get member's name for the log entry
    $name_stmt = $conn->prepare("SELECT first_name, last_name FROM members WHERE member_id = ?");
    $name_stmt->bind_param("s", $member_id);
    $name_stmt->execute();
    $name_result = $name_stmt->get_result();
    $member_data = $name_result->fetch_assoc();
    $member_name = $member_data['first_name'] . ' ' . $member_data['last_name'];

    // Prepare the delete statement
    $delete_stmt = $conn->prepare("DELETE FROM members WHERE member_id = ?");
    $delete_stmt->bind_param("s", $member_id);

    // Try to execute the delete statement
    if ($delete_stmt->execute()) {
        // Log the deletion
        log_activity(
            "Member Deletion", 
            "Deleted member: $member_name (ID: $member_id)", 
            $officer_id
        );
        
        $_SESSION['success_message'] = "Member successfully deleted.";
    } else {
        $_SESSION['warning_message'] = "Error deleting member. Please try again. " . $conn->error;
    }

    // Close statements
    $check_officer_stmt->close();
    $name_stmt->close();
    $delete_stmt->close();

    // Redirect back to members page
    header("Location: members.php");
    exit();
?>