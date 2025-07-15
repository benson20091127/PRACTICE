<?php
session_start();
header('Content-Type: application/json');
try {
    $pdo = new PDO('mysql:host=localhost;dbname=xiuxian;charset=utf8mb4', 'admin', '12345');
} catch (Exception $e) {
    echo json_encode(['status'=>-1, 'error'=>'資料庫連線錯誤']);
    exit;
}
$member_id = $_SESSION['member_id'] ?? 0;
if(!$member_id){
    echo json_encode(['status'=>0, 'message'=>'請先登入']);
    exit;
}
$amount = intval($_POST['amount'] ?? 0);
if($amount !== 0){
    $pdo->prepare('UPDATE members SET points=points+? WHERE member_id=?')->execute([$amount, $member_id]);
}
$stmt = $pdo->prepare('SELECT points FROM members WHERE member_id=?');
$stmt->execute([$member_id]);
$points = $stmt->fetchColumn();
echo json_encode(['status'=>1, 'points'=>$points]);
