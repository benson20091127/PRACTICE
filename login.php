<?php
session_start();
header('Content-Type: application/json');
try {
    $pdo = new PDO('mysql:host=localhost;dbname=xiuxian;charset=utf8mb4', 'admin', '12345');
} catch (Exception $e) {
    echo json_encode(['status'=>-1, 'error'=>'資料庫連線錯誤']);
    exit;
}
$username = $_POST['username'] ?? '';
$password = $_POST['password'] ?? '';
$stmt = $pdo->prepare('SELECT member_id, password FROM members WHERE username=?');
$stmt->execute([$username]);
$row = $stmt->fetch(PDO::FETCH_ASSOC);
if($row && $row['password']===$password){
    $_SESSION['member_id'] = $row['member_id'];
    echo json_encode(['status'=>1, 'message'=>'登入成功']);
} else {
    echo json_encode(['status'=>0, 'message'=>'帳號或密碼錯誤']);
}
