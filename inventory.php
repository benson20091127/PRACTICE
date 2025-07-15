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
    echo json_encode(['status'=>0, 'message'=>'請先登入', 'items'=>[]]);
    exit;
}
$stmt = $pdo->prepare('
    SELECT p.name, p.type, p.attack, p.defense, p.level, i.acquired_at
    FROM inventory i
    JOIN products p ON i.product_id = p.product_id
    WHERE i.member_id=?
    ORDER BY i.acquired_at DESC
');
$stmt->execute([$member_id]);
$items = $stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode(['status'=>1, 'items'=>$items]);
