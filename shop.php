<?php
error_reporting(0);
ini_set('display_errors', 0);
if (session_status() !== PHP_SESSION_ACTIVE) session_start();
header('Content-Type: application/json');
try {
    $pdo = new PDO('mysql:host=localhost;dbname=xiuxian;charset=utf8mb4', 'root', '');
} catch (Exception $e) {
    echo json_encode(['status'=>-1, 'error'=>'資料庫連線錯誤']);
    exit;
}
$member_id = $_SESSION['member_id'] ?? 0;
// debug
// echo json_encode(['debug_member_id'=>$member_id]); exit;
if(!$member_id){
    echo json_encode(['status'=>0, 'message'=>'請先登入']);
    exit;
}
if($_SERVER['REQUEST_METHOD']=='POST' && isset($_POST['buy'])){
    $pid = intval($_POST['product_id'] ?? 0);
    $stmt = $pdo->prepare('SELECT price, level FROM products WHERE product_id=?');
    $stmt->execute([$pid]);
    $product = $stmt->fetch(PDO::FETCH_ASSOC);
    if(!$product){
        echo json_encode(['status'=>0, 'message'=>'商品不存在']);
        exit;
    }
    $stmt = $pdo->prepare('SELECT points, level FROM members WHERE member_id=?');
    $stmt->execute([$member_id]);
    $member = $stmt->fetch(PDO::FETCH_ASSOC);
    if($member['points'] < $product['price']){
        echo json_encode(['status'=>0, 'message'=>'點數不足']);
        exit;
    }
    if($member['level'] < $product['level']){
        echo json_encode(['status'=>0, 'message'=>'等級不足，無法購買此商品']);
        exit;
    }
    $pdo->beginTransaction();
    $pdo->prepare('UPDATE members SET points=points-? WHERE member_id=?')->execute([$product['price'], $member_id]);
    $pdo->prepare('INSERT INTO inventory (member_id, product_id) VALUES (?, ?)')->execute([$member_id, $pid]);
    $pdo->commit();
    echo json_encode(['status'=>1, 'message'=>'購買成功']);
    exit;
}
$stmt = $pdo->prepare('SELECT points, level, exp FROM members WHERE member_id=?');
$stmt->execute([$member_id]);
$member = $stmt->fetch(PDO::FETCH_ASSOC);
$points = $member['points'];
$level = $member['level'];
$exp = $member['exp'] ?? 0;
$products = $pdo->query('SELECT * FROM products')->fetchAll(PDO::FETCH_ASSOC);
echo json_encode(['status'=>1, 'points'=>$points, 'products'=>$products, 'level'=>$level, 'exp'=>$exp]);
