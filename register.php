<?php
header('Content-Type: application/json');
try {
    $pdo = new PDO('mysql:host=localhost;dbname=xiuxian;charset=utf8mb4', 'admin', '12345');
} catch (Exception $e) {
    echo json_encode(['status'=>-1, 'error'=>'資料庫連線錯誤']);
    exit;
}
$username = $_POST['username'] ?? '';
$password = $_POST['password'] ?? '';
$nickname = $_POST['nickname'] ?? '';
if(!$username || !$password || !$nickname){
    echo json_encode(['status'=>0, 'message'=>'欄位不得為空']);
    exit;
}
$stmt = $pdo->prepare('SELECT member_id FROM members WHERE username=?');
$stmt->execute([$username]);
if($stmt->fetch()){
    echo json_encode(['status'=>0, 'message'=>'帳號已存在']);
    exit;
}
$stmt = $pdo->prepare('INSERT INTO members (username, password, nickname) VALUES (?, ?, ?)');
if($stmt->execute([$username, $password, $nickname])){
    echo json_encode(['status'=>1, 'message'=>'註冊成功']);
} else {
    echo json_encode(['status'=>0, 'message'=>'註冊失敗']);
}
