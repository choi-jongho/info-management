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
        $_SESSION['error_message'] = "No Member ID provided!";
        header("Location: members.php");
        exit();
    }

    // Sanitize the ID
    $member_id = sanitize_input($_GET['id']);

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
