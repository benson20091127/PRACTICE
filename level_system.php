<?php
error_reporting(0);
ini_set('display_errors', 0);
if (session_status() !== PHP_SESSION_ACTIVE) session_start();
header('Content-Type: application/json');

try {
    $pdo = new PDO('mysql:host=localhost;dbname=xiuxian;charset=utf8mb4', 'root', '');
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (Exception $e) {
    echo json_encode(['status'=>-1, 'error'=>'資料庫連線錯誤']);
    exit;
}

$member_id = $_SESSION['member_id'] ?? 0;
if(!$member_id){
    echo json_encode(['status'=>0, 'message'=>'請先登入']);
    exit;
}

// 檢查升級 - 優化版本
function checkLevelUp($pdo, $member_id) {
    $stmt = $pdo->prepare('SELECT level, exp FROM members WHERE member_id=?');
    $stmt->execute([$member_id]);
    $member = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if(!$member) return ['leveled_up' => false];
    
    $currentLevel = $member['level'];
    $currentExp = $member['exp'];
    $levelsGained = 0;
    $oldLevel = $currentLevel;
    
    // 支持連續升級
    while($currentLevel < 10) {
        $expNeeded = $currentLevel * 100; // 升級所需經驗值計算：level * 100
        
        if($currentExp >= $expNeeded) {
            $currentLevel++;
            $currentExp -= $expNeeded;
            $levelsGained++;
        } else {
            break;
        }
    }
    
    if($levelsGained > 0) {
        // 更新等級和經驗值
        $pdo->prepare('UPDATE members SET level=?, exp=? WHERE member_id=?')
            ->execute([$currentLevel, $currentExp, $member_id]);
            
        return [
            'leveled_up' => true,
            'levels_gained' => $levelsGained,
            'old_level' => $oldLevel,
            'new_level' => $currentLevel,
            'remaining_exp' => $currentExp
        ];
    }
    
    return ['leveled_up' => false];
}

// 添加經驗值
if($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['add_exp'])) {
    $exp_amount = intval($_POST['exp_amount'] ?? 0);
    
    if($exp_amount > 0) {
        $pdo->prepare('UPDATE members SET exp=exp+? WHERE member_id=?')
            ->execute([$exp_amount, $member_id]);
    }
    
    // 檢查是否升級
    $levelResult = checkLevelUp($pdo, $member_id);
    
    // 返回當前狀態
    $stmt = $pdo->prepare('SELECT level, exp FROM members WHERE member_id=?');
    $stmt->execute([$member_id]);
    $member = $stmt->fetch(PDO::FETCH_ASSOC);
    
    echo json_encode([
        'status' => 1,
        'level' => $member['level'],
        'exp' => $member['exp'],
        'level_result' => $levelResult,
        'exp_added' => $exp_amount
    ]);
    exit;
}

// 獲取當前等級和經驗值
$stmt = $pdo->prepare('SELECT level, exp FROM members WHERE member_id=?');
$stmt->execute([$member_id]);
$member = $stmt->fetch(PDO::FETCH_ASSOC);

// 計算到下一級所需經驗值
$expToNext = $member['level'] < 10 ? ($member['level'] * 100) - $member['exp'] : 0;

echo json_encode([
    'status' => 1,
    'level' => $member['level'],
    'exp' => $member['exp'],
    'exp_to_next' => $expToNext
]);
?>
