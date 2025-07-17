<?php
session_start();
session_destroy();
header('Content-Type: application/json');
echo json_encode(['status' => 1, 'message' => '已登出']);
?>
