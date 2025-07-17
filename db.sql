DROP DATABASE IF EXISTS xiuxian;
CREATE DATABASE xiuxian CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE xiuxian;

-- 创建会员表
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    nickname VARCHAR(50) NOT NULL,
    points INT DEFAULT 2000,
    level INT DEFAULT 1,
    exp INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 创建商品表
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type ENUM('武器','防具','祕笈') NOT NULL,
    attack INT DEFAULT 0,
    defense INT DEFAULT 0,
    level INT DEFAULT 1,
    price INT NOT NULL
);

-- 创建背包表
CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    product_id INT NOT NULL,
    acquired_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- 创建妖兽表
CREATE TABLE beasts (
    beast_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    level INT NOT NULL,
    exp_reward INT NOT NULL,
    points_reward INT NOT NULL,
    drop_rate DECIMAL(3,2) NOT NULL,
    description TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 创建妖兽遭遇记录表
CREATE TABLE beast_encounters (
    encounter_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    beast_id INT NOT NULL,
    result ENUM('victory','defeat','escape_success','escape_fail','death') NOT NULL,
    exp_gained INT DEFAULT 0,
    points_gained INT DEFAULT 0,
    item_dropped VARCHAR(100),
    encounter_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (beast_id) REFERENCES beasts(beast_id) ON DELETE CASCADE
);

-- 插入测试会员
INSERT INTO members (username, password, nickname, points, level, exp) VALUES 
('xianren', '1234', '仙人', 5000, 1, 0),
('admin', 'admin', '管理员', 99999999, 15, 0);

-- 插入商品数据 - 最新版本
INSERT INTO products (name, type, attack, defense, level, price) VALUES
-- 初級武器 (Lv.1-2) - 入門價格
('木劍', '武器', 8, 1, 1, 500),
('青銅劍', '武器', 15, 3, 1, 1000),
('七星劍', '武器', 25, 5, 2, 2500),
('寒鐵刀', '武器', 30, 2, 2, 3000),

-- 初級武器進階 (Lv.3-5) - 大幅提升
('精鋼劍', '武器', 35, 6, 3, 15000),
('流星錘', '武器', 38, 4, 3, 18000),
('玄鐵重劍', '武器', 45, 8, 4, 35000),
('赤焰刀', '武器', 50, 7, 4, 40000),
('龍吟劍', '武器', 60, 12, 5, 75000),

-- 中級武器 (Lv.6-10) - 極高價格
('霸王槍', '武器', 70, 15, 6, 150000),
('鳳鳴劍', '武器', 80, 18, 7, 250000),
('屠龍刀', '武器', 95, 22, 8, 400000),
('倚天劍', '武器', 110, 28, 9, 650000),
('軒轅劍', '武器', 130, 35, 10, 1000000),

-- 高級武器 (Lv.11-15) - 天價
('盤古斧', '武器', 160, 45, 11, 1800000),
('弒神劍', '武器', 200, 60, 12, 3000000),
('混沌劍', '武器', 250, 80, 13, 5000000),
('創世神兵', '武器', 320, 100, 14, 8000000),
('滅世之刃', '武器', 400, 120, 15, 15000000),

-- 初級防具 (Lv.1-2)
('布衣', '防具', 0, 12, 1, 600),
('皮甲', '防具', 0, 20, 1, 1200),
('紫霞仙袍', '防具', 5, 40, 2, 3500),
('青蓮道袍', '防具', 8, 45, 2, 4000),

-- 初級防具進階 (Lv.3-5)
('鐵甲', '防具', 5, 55, 3, 20000),
('銀鱗甲', '防具', 10, 65, 3, 25000),
('金剛盾甲', '防具', 15, 80, 4, 50000),
('雲夢披風', '防具', 18, 75, 4, 55000),
('白鶴羽衣', '防具', 25, 100, 5, 100000),

-- 中級防具 (Lv.6-10)
('龍鱗甲', '防具', 30, 130, 6, 200000),
('鳳凰羽衣', '防具', 40, 160, 7, 350000),
('玄武甲', '防具', 50, 200, 8, 600000),
('麒麟聖衣', '防具', 65, 250, 9, 1000000),
('神龍護甲', '防具', 80, 300, 10, 1600000),

-- 高級防具 (Lv.11-15)
('混沌戰甲', '防具', 100, 400, 11, 2800000),
('天帝聖袍', '防具', 130, 500, 12, 4500000),
('創世聖甲', '防具', 170, 650, 13, 7500000),
('無極戰袍', '防具', 220, 800, 14, 12000000),
('永恆神甲', '防具', 300, 1000, 15, 20000000),

-- 初級祕笈 (Lv.1-2)
('基礎心法', '祕笈', 12, 10, 1, 1500),
('太極拳譜', '祕笈', 20, 18, 2, 3500),
('易筋經', '祕笈', 28, 25, 2, 5000),

-- 初級祕笈進階 (Lv.3-5)
('洗髓經', '祕笈', 35, 30, 3, 25000),
('九陽真經', '祕笈', 55, 40, 4, 60000),
('天罡心法', '祕笈', 70, 50, 5, 120000),

-- 中級祕笈 (Lv.6-10)
('神鶴令', '祕笈', 90, 65, 6, 250000),
('乾坤大挪移', '祕笈', 120, 85, 7, 450000),
('九陰真經', '祕笈', 150, 110, 8, 800000),
('無極心法', '祕笈', 190, 140, 9, 1400000),
('紫霞神功', '祕笈', 240, 180, 10, 2200000),

-- 高級祕笈 (Lv.11-15)
('混元一氣功', '祕笈', 300, 220, 11, 3800000),
('天道心經', '祕笈', 380, 280, 12, 6000000),
('大道無形', '祕笈', 480, 350, 13, 10000000),
('無上仙訣', '祕笈', 600, 450, 14, 16000000),
('混沌真經', '祕笈', 800, 600, 15, 25000000),

-- 特殊道具 - 大幅調整價格
('靈丹妙藥', '祕笈', 0, 0, 1, 8000),
('仙鶴靈丹', '祕笈', 0, 0, 3, 25000),
('千年人參', '祕笈', 0, 0, 5, 80000),
('萬年靈芝', '祕笈', 0, 0, 7, 300000),
('長生丹', '祕笈', 0, 0, 9, 1200000),
('不死藥', '祕笈', 0, 0, 12, 5000000),
('結局券', '祕笈', 0, 0, 300, 99999999),

-- 特殊裝備 - 調整價格
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

-- 插入妖兽数据 - 30种妖兽
INSERT INTO beasts (name, level, exp_reward, points_reward, drop_rate, description) VALUES
-- 初级妖兽 (等级1-3)
('金玥真蟾', 1, 50, 200, 0.10, '传说中的金色蟾蜍，善于吐毒雾'),
('檮杌', 2, 80, 350, 0.12, '上古四凶之一，凶恶异常'),
('窮奇', 2, 100, 400, 0.15, '上古四凶之一，好斗成性'),
('九尾狐', 3, 120, 500, 0.18, '狐族至尊，智慧超群'),
('饕餮', 3, 150, 600, 0.20, '上古四凶之一，贪婪无度'),

-- 中级妖兽 (等级4-6)
('混沌', 4, 200, 800, 0.22, '上古四凶之一，力大无穷'),
('梼杌', 4, 220, 900, 0.25, '凶兽梼杌，好杀成性'),
('白澤', 5, 280, 1200, 0.28, '仁兽白澤，知晓万物'),
('夔牛', 5, 300, 1350, 0.30, '雷兽夔牛，雷鸣阵阵'),
('鳳凰', 6, 400, 1800, 0.32, '百鸟之王，浴火重生'),

-- 高级妖兽 (等级7-9)
('青龍', 7, 500, 2500, 0.35, '东方神兽，掌控木属性'),
('白虎', 7, 520, 2600, 0.35, '西方神兽，掌控金属性'),
('朱雀', 8, 600, 3200, 0.38, '南方神兽，掌控火属性'),
('玄武', 8, 650, 3500, 0.40, '北方神兽，掌控水属性'),
('麒麟', 9, 800, 4500, 0.42, '仁兽之首，祥瑞之兽'),

-- 神级妖兽 (等级10-12)
('燭龍', 10, 1000, 6000, 0.45, '时间之龙，掌控昼夜'),
('應龍', 10, 1100, 6500, 0.45, '神龙之祖，有翼神龙'),
('龍王', 11, 1300, 8000, 0.48, '四海龙王，呼风唤雨'),
('鯤鵬', 11, 1400, 8500, 0.50, '北海巨兽，化鹏九万里'),
('太古龍皇', 12, 1800, 12000, 0.52, '龙族至尊，万龙之皇'),

-- 上古凶兽 (等级13-15)
('混沌吞天獸', 13, 2200, 15000, 0.55, '混沌凶兽，吞噬万物'),
('虛空噬魂蛇', 13, 2400, 16000, 0.55, '虚空恶蛇，噬人魂魄'),
('滅世魔狼', 14, 2800, 20000, 0.58, '末日狼王，嗜血成性'),
('弒神魔龍', 14, 3000, 22000, 0.60, '逆天魔龙，弒杀神灵'),
('創世神獸', 15, 4000, 35000, 0.65, '开天神兽，创造万物'),

-- 传说妖兽 (特殊)
('上古魔神', 20, 8000, 80000, 0.80, '远古魔神，毁天灭地'),
('混元始祖', 25, 15000, 150000, 0.90, '混元之祖，万物起源'),
('天道化身', 30, 30000, 300000, 0.95, '天道显化，执掌法则'),
('無極天魔', 35, 50000, 500000, 1.00, '无极魔主，颠倒乾坤'),
('創世之靈', 50, 100000, 1000000, 1.00, '创世之灵，超越一切');

-- 创建索引以提高查询性能
CREATE INDEX idx_members_username ON members(username);
CREATE INDEX idx_members_level ON members(level);
CREATE INDEX idx_products_type ON products(type);
CREATE INDEX idx_products_level ON products(level);
CREATE INDEX idx_inventory_member ON inventory(member_id);
CREATE INDEX idx_beasts_level ON beasts(level);
CREATE INDEX idx_encounters_member ON beast_encounters(member_id);

-- 显示创建结果
SELECT '数据库创建完成！' as status;
SELECT COUNT(*) as '商品总数' FROM products;
SELECT COUNT(*) as '妖兽总数' FROM beasts;
SELECT COUNT(*) as '会员总数' FROM members;
