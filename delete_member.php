<?php
    session_start();
    include('database.php');
    require_once('functions.php');

    // Check if officer is logged in
    $officer_id = $_SESSION['officer_id'] ?? null;
    if (!$officer_id) {
        // Officer not logged in, redirect to login page
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
    $id = $conn->real_escape_string($_GET['id']);

    // Verify if the member exists
    $result = $conn->query("SELECT * FROM members WHERE member_id = '$id'");
    if ($result->num_rows === 0) {
        $_SESSION['error_message'] = "Member not found!";
        header("Location: members.php");
        exit();
    }

    $member = $result->fetch_assoc();
    $member_name = $member['first_name'] . ' ' . $member['last_name'];

    // Perform deletion
    $stmt = $conn->prepare("DELETE FROM members WHERE member_id = ?");
    $stmt->bind_param("s", $id);
    if ($stmt->execute()) {
        $_SESSION['success_message'] = "Member deleted successfully.";
        log_activity("Delete Member", "Deleted member: $member_name (ID: $id)", $officer_id);
    } else {
        $_SESSION['error_message'] = "Error deleting member: " . $stmt->error;
    }

    $stmt->close();
    $conn->close();
    header("Location: members.php");
    exit();
?>
