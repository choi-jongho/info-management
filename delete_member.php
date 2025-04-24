<?php
    session_start();
    include('database.php');
    require_once('functions.php');

    // Check if officer is logged in
    $officer_id = $_SESSION['officer_id'] ?? null;
    if (!$officer_id) {
        header("Location: login.php");
        exit();
    }

    // Check if ID is provided
    if (!isset($_GET['id']) || empty($_GET['id'])) {
        $_SESSION['error_message'] = "No Student ID provided!";
        header("Location: members.php");
        exit();
    }

    // Sanitize the ID
    $member_id = sanitize_input($_GET['id']);

    // Check if member is an officer
    $is_officer_query = $conn->prepare("SELECT COUNT(*) FROM officers WHERE member_id = ?");
    $is_officer_query->bind_param("s", $member_id);
    $is_officer_query->execute();
    $is_officer_query->bind_result($officer_count);
    $is_officer_query->fetch();
    $is_officer_query->close();

    if ($officer_count > 0) {
        $_SESSION['warning_message'] = "Cannot delete a member who is an officer.";
        header("Location: members.php");
        exit();
    }

    // Check if member status is active
    $status_query = $conn->prepare("SELECT status FROM members WHERE member_id = ?");
    $status_query->bind_param("s", $member_id);
    $status_query->execute();
    $status_query->bind_result($member_status);
    $status_query->fetch();
    $status_query->close();

    if ($member_status === 'Active') {
        $_SESSION['warning_message'] = "Cannot delete a member with Active status.";
        header("Location: members.php");
        exit();
    }

    // Call the delete_member function
    if (delete_member($member_id, $officer_id)) {
        $_SESSION['success_message'] = "Member deleted successfully.";
    } else {
        $_SESSION['error_message'] = "Error deleting member.";
    }

    // Redirect back to members page
    header("Location: members.php");
    exit();
?>