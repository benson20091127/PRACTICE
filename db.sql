CREATE DATABASE IF NOT EXISTS xiuxian CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE xiuxian;

DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS members;

CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    nickname VARCHAR(50) NOT NULL,
    points INT DEFAULT 2000,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type ENUM('武器','防具','祕笈') NOT NULL,
    attack INT DEFAULT 0,
    defense INT DEFAULT 0,
    level INT DEFAULT 1,
    price INT NOT NULL
);

CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    product_id INT NOT NULL,
    acquired_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 會員範例資料
INSERT INTO members (username, password, nickname, points)
VALUES ('xianren', '1234', '仙人', 2000);

-- 商品範例資料
INSERT INTO products (name, type, attack, defense, level, price) VALUES
('七星劍', '武器', 20, 5, 1, 500),
('紫霞仙袍', '防具', 0, 30, 2, 800),
('九陽真經', '祕笈', 50, 10, 3, 1500),
('青鋒劍', '武器', 15, 2, 1, 350),
('金剛盾', '防具', 0, 40, 3, 1200),
('太極拳譜', '祕笈', 30, 20, 2, 900),
('赤焰刀', '武器', 28, 0, 2, 700),
('雲夢披風', '防具', 0, 18, 1, 400),
('天罡心法', '祕笈', 40, 25, 3, 1800),
('玄鐵重劍', '武器', 35, 8, 4, 2200),
('碧水寒衣', '防具', 0, 55, 5, 3200),
('神鶴令', '祕笈', 60, 30, 5, 3500),
('龍吟刀', '武器', 45, 5, 5, 2600),
('白鶴羽衣', '防具', 0, 70, 6, 4000),
('無極心法', '祕笈', 80, 40, 7, 5000),
('結局券', '祕笈', 0, 0, 10, 5000),
('靈丹妙藥', '祕笈', 0, 0, 0, 800),
('仙鶴靈丹', '祕笈', 0, 0, 0, 1200),
('長生丹', '祕笈', 0, 0, 0, 2500),
('不死藥', '祕笈', 0, 0, 0, 5000);
