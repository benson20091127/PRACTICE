DROP DATABASE IF EXISTS xiuxian;
CREATE DATABASE xiuxian CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE xiuxian;

-- 📝 建立會員資料表
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '會員編號（主鍵）',
    username VARCHAR(50) NOT NULL UNIQUE COMMENT '登入帳號（唯一）',
    password VARCHAR(255) NOT NULL COMMENT '登入密碼（哈希儲存）',
    nickname VARCHAR(50) NOT NULL COMMENT '遊戲暱稱',
    points INT DEFAULT 2000 COMMENT '商城點數（預設 2000）',
    level INT DEFAULT 1 COMMENT '會員等級（預設 1）',
    exp INT DEFAULT 0 COMMENT '會員經驗值（預設 0）',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '註冊時間（建立時間戳）'
) COMMENT='會員資料表：儲存玩家基本資料';

-- 📝 建立商城商品資料表
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '商品編號（主鍵）',
    name VARCHAR(100) NOT NULL COMMENT '商品名稱',
    type ENUM('武器','防具','祕笈') NOT NULL COMMENT '商品類型（武器、防具、祕笈）',
    attack INT DEFAULT 0 COMMENT '攻擊值（預設 0）',
    defense INT DEFAULT 0 COMMENT '防禦值（預設 0）',
    level INT DEFAULT 1 COMMENT '所需等級（預設 1）',
    price INT NOT NULL COMMENT '商品價格（點數）'
) COMMENT='商城商品資料表：儲存所有可購買商品';

-- 📝 建立會員背包資料表
CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '背包紀錄編號（主鍵）',
    member_id INT NOT NULL COMMENT '會員編號（外鍵，關聯 members）',
    product_id INT NOT NULL COMMENT '商品編號（外鍵，關聯 products）',
    acquired_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '獲得時間（建立時間戳）',
    CONSTRAINT fk_inventory_member FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    CONSTRAINT fk_inventory_product FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
) COMMENT='會員背包資料表：紀錄玩家擁有的物品';

-- 📝 建立妖獸資料表
CREATE TABLE beasts (
    beast_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '妖獸編號（主鍵）',
    name VARCHAR(100) NOT NULL COMMENT '妖獸名稱',
    level INT NOT NULL COMMENT '妖獸等級',
    exp_reward INT NOT NULL COMMENT '擊敗後獲得經驗值',
    points_reward INT NOT NULL COMMENT '擊敗後獲得商城點數',
    drop_rate DECIMAL(3,2) NOT NULL COMMENT '掉落率（0.00 ~ 1.00）',
    description TEXT COMMENT '妖獸描述',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '建立時間（時間戳）'
) COMMENT='妖獸資料表：儲存遊戲中所有妖獸資訊';

-- 📝 建立妖獸遭遇記錄資料表
CREATE TABLE beast_encounters (
    encounter_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '遭遇紀錄編號（主鍵）',
    member_id INT NOT NULL COMMENT '會員編號（外鍵，關聯 members）',
    beast_id INT NOT NULL COMMENT '妖獸編號（外鍵，關聯 beasts）',
    result ENUM('victory','defeat','escape_success','escape_fail','death') NOT NULL COMMENT '遭遇結果（勝利/失敗/逃脫成功等）',
    exp_gained INT DEFAULT 0 COMMENT '獲得經驗值',
    points_gained INT DEFAULT 0 COMMENT '獲得商城點數',
    item_dropped VARCHAR(100) COMMENT '掉落的物品名稱',
    encounter_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '遭遇時間（時間戳）',
    CONSTRAINT fk_encounters_member FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    CONSTRAINT fk_encounters_beast FOREIGN KEY (beast_id) REFERENCES beasts(beast_id) ON DELETE CASCADE
) COMMENT='妖獸遭遇記錄資料表：紀錄會員與妖獸戰鬥歷史';

-- 📦 建立索引（提高查詢效能）
CREATE INDEX idx_members_username ON members(username);
CREATE INDEX idx_members_level ON members(level);
CREATE INDEX idx_products_type ON products(type);
CREATE INDEX idx_products_level ON products(level);
CREATE INDEX idx_inventory_member ON inventory(member_id);
CREATE INDEX idx_beasts_level ON beasts(level);
CREATE INDEX idx_encounters_member ON beast_encounters(member_id);

-- 📥 插入測試會員
INSERT INTO members (username, password, nickname, points, level, exp) VALUES 
('xianren', '1234', '仙人', 5000, 1, 0),
('admin', 'admin', '管理員', 99999999, 15, 0);

-- 📥 插入完整商城商品資料
INSERT INTO products (name, type, attack, defense, level, price) VALUES
('木劍', '武器', 8, 1, 1, 500),
('青銅劍', '武器', 15, 3, 1, 1000),
('七星劍', '武器', 25, 5, 2, 2500),
('寒鐵刀', '武器', 30, 2, 2, 3000),
('精鋼劍', '武器', 35, 6, 3, 15000),
('流星錘', '武器', 38, 4, 3, 18000),
('玄鐵重劍', '武器', 45, 8, 4, 35000),
('赤焰刀', '武器', 50, 7, 4, 40000),
('龍吟劍', '武器', 60, 12, 5, 75000),
('霸王槍', '武器', 70, 15, 6, 150000),
('鳳鳴劍', '武器', 80, 18, 7, 250000),
('屠龍刀', '武器', 95, 22, 8, 400000),
('倚天劍', '武器', 110, 28, 9, 650000),
('軒轅劍', '武器', 130, 35, 10, 1000000),
('盤古斧', '武器', 160, 45, 11, 1800000),
('弒神劍', '武器', 200, 60, 12, 3000000),
('混沌劍', '武器', 250, 80, 13, 5000000),
('創世神兵', '武器', 320, 100, 14, 8000000),
('滅世之刃', '武器', 400, 120, 15, 15000000),
('布衣', '防具', 0, 12, 1, 600),
('皮甲', '防具', 0, 20, 1, 1200),
('紫霞仙袍', '防具', 5, 40, 2, 3500),
('青蓮道袍', '防具', 8, 45, 2, 4000),
('鐵甲', '防具', 5, 55, 3, 20000),
('銀鱗甲', '防具', 10, 65, 3, 25000),
('金剛盾甲', '防具', 15, 80, 4, 50000),
('雲夢披風', '防具', 18, 75, 4, 55000),
('白鶴羽衣', '防具', 25, 100, 5, 100000),
('龍鱗甲', '防具', 30, 130, 6, 200000),
('鳳凰羽衣', '防具', 40, 160, 7, 350000),
('玄武甲', '防具', 50, 200, 8, 600000),
('麒麟聖衣', '防具', 65, 250, 9, 1000000),
('神龍護甲', '防具', 80, 300, 10, 1600000),
('混沌戰甲', '防具', 100, 400, 11, 2800000),
('天帝聖袍', '防具', 130, 500, 12, 4500000),
('創世聖甲', '防具', 170, 650, 13, 7500000),
('無極戰袍', '防具', 220, 800, 14, 12000000),
('永恆神甲', '防具', 300, 1000, 15, 20000000),
('基礎心法', '祕笈', 12, 10, 1, 1500),
('太極拳譜', '祕笈', 20, 18, 2, 3500),
('易筋經', '祕笈', 28, 25, 2, 5000),
('洗髓經', '祕笈', 35, 30, 3, 25000),
('九陽真經', '祕笈', 55, 40, 4, 60000),
('天罡心法', '祕笈', 70, 50, 5, 120000),
('神鶴令', '祕笈', 90, 65, 6, 250000),
('乾坤大挪移', '祕笈', 120, 85, 7, 450000),
('九陰真經', '祕笈', 150, 110, 8, 800000),
('無極心法', '祕笈', 190, 140, 9, 1400000),
('紫霞神功', '祕笈', 240, 180, 10, 2200000),
('混元一氣功', '祕笈', 300, 220, 11, 3800000),
('天道心經', '祕笈', 380, 280, 12, 6000000),
('大道無形', '祕笈', 480, 350, 13, 10000000),
('無上仙訣', '祕笈', 600, 450, 14, 16000000),
('混沌真經', '祕笈', 800, 600, 15, 25000000),
('靈丹妙藥', '祕笈', 0, 0, 1, 8000),
('仙鶴靈丹', '祕笈', 0, 0, 3, 25000),
('千年人參', '祕笈', 0, 0, 5, 80000),
('萬年靈芝', '祕笈', 0, 0, 7, 300000),
('長生丹', '祕笈', 0, 0, 9, 1200000),
('不死藥', '祕笈', 0, 0, 12, 5000000),
('結局券', '祕笈', 0, 0, 300, 99999999),
('護身符', '防具', 0, 30, 2, 8000),
('聚氣珠', '武器', 40, 0, 3, 15000),
('避水珠', '防具', 0, 50, 4, 35000),
('夜明珠', '武器', 30, 30, 4, 45000),
('定風珠', '防具', 20, 75, 5, 85000),
('避火珠', '防具', 25, 100, 6, 180000),
('辟邪劍', '武器', 110, 25, 7, 350000),
('混沌珠', '武器', 100, 100, 8, 600000),
('太極八卦', '祕笈', 150, 150, 10, 2000000),
('陰陽魚', '武器', 200, 80, 11, 4000000);

-- 📥 插入完整妖獸資料
INSERT INTO beasts (name, level, exp_reward, points_reward, drop_rate, description) VALUES
('金玥真蟾', 1, 50, 200, 0.10, '傳說中的金色蟾蜍，善於吐毒霧'),
('檮杌', 2, 80, 350, 0.12, '上古四凶之一，兇惡異常'),
('窮奇', 2, 100, 400, 0.15, '上古四凶之一，好戰成性'),
('九尾狐', 3, 120, 500, 0.18, '狐族至尊，智慧超群'),
('饕餮', 3, 150, 600, 0.20, '上古四凶之一，貪婪無度'),
('混沌', 4, 200, 800, 0.22, '混沌凶獸，力大無窮'),
('梼杌', 4, 220, 900, 0.25, '凶獸梼杌，殘暴成性'),
('白澤', 5, 280, 1200, 0.28, '仁獸白澤，知曉萬物'),
('夔牛', 5, 300, 1350, 0.30, '雷獸夔牛，雷鳴陣陣'),
('鳳凰', 6, 400, 1800, 0.32, '百鳥之王，浴火重生'),
('青龍', 7, 500, 2500, 0.35, '東方神獸，掌控木屬性'),
('白虎', 7, 520, 2600, 0.35, '西方神獸，掌控金屬性'),
('朱雀', 8, 600, 3200, 0.38, '南方神獸，掌控火屬性'),
('玄武', 8, 650, 3500, 0.40, '北方神獸，掌控水屬性'),
('麒麟', 9, 800, 4500, 0.42, '仁獸之首，祥瑞之獸'),
('燭龍', 10, 1000, 6000, 0.45, '時間之龍，掌控晝夜'),
('應龍', 10, 1100, 6500, 0.45, '神龍之祖，有翼神龍'),
('龍王', 11, 1300, 8000, 0.48, '四海龍王，呼風喚雨'),
('鯤鵬', 11, 1400, 8500, 0.50, '北海巨獸，化鵬九萬里'),
('太古龍皇', 12, 1800, 12000, 0.52, '龍族至尊，萬龍之皇'),
('混沌吞天獸', 13, 2200, 15000, 0.55, '混沌凶獸，吞噬萬物'),
('虛空噬魂蛇', 13, 2400, 16000, 0.55, '虛空惡蛇，噬人魂魄'),
('滅世魔狼', 14, 2800, 20000, 0.58, '末日狼王，嗜血成性'),
('弒神魔龍', 14, 3000, 22000, 0.60, '逆天魔龍，弒殺神靈'),
('創世神獸', 15, 4000, 35000, 0.65, '開天神獸，創造萬物'),
('上古魔神', 20, 8000, 80000, 0.80, '遠古魔神，毀天滅地'),
('混元始祖', 25, 15000, 150000, 0.90, '混元之祖，萬物起源'),
('天道化身', 30, 30000, 300000, 0.95, '天道顯化，執掌法則'),
('無極天魔', 35, 50000, 500000, 1.00, '無極魔主，顛倒乾坤'),
('創世之靈', 50, 100000, 1000000, 1.00, '創世之靈，超越一切');

-- ✅ 顯示建立結果
SELECT '資料庫建立完成！' AS 狀態;
