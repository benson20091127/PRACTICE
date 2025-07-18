---

## mode: edit

# 🎯 專案目標

建立一個前後端分離的**文字修仙互動式網頁遊戲**，包含完整的會員系統、商城系統、背包系統和劇情冒險系統。

---

# 🌐 前端架構

## 📁 檔案結構
```
c:\xampp\htdocs\PRACTICE\
├── frontend/
│   ├── login.html          # 登入頁面
│   ├── register.html       # 註冊頁面
│   ├── shop.html           # 商城頁面
│   ├── inventory.html      # 背包頁面
│   └── story.html          # 故事冒險頁面
├── css/
│   └── style.css           # 全站統一古風樣式
├── js/
│   └── main.js             # 前端 JavaScript 邏輯
└── backend/
    ├── config.php          # 資料庫配置
    ├── login.php           # 登入 API
    ├── register.php        # 註冊 API
    ├── shop.php            # 商城 API
    ├── inventory.php       # 背包 API
    ├── story.php           # 故事 API
    ├── add_points.php      # 點數操作 API
    └── use_item.php        # 道具使用 API
```

## 🎨 設計規範

### 視覺風格
* **主題色彩**：金色 (#D4AF37)、深褐色 (#8B4513)、墨綠色 (#2F4F2F)
* **背景效果**：漸層背景 + SVG 雲霧動畫
* **裝飾元素**：古風花紋邊框、飄逸文字效果
* **字體設計**：中文使用楷體或仿宋，英文使用 serif 字體

### 響應式設計 (RWD)
* **Bootstrap 5.3.1** 框架 (CDN)
* **斷點設計**：桌機 (≥1200px)、平板 (768-1199px)、手機 (<768px)
* **字體大小**：標題 24px+、內文 16px+、按鈕 18px+
* **間距設計**：區塊間距 30px+、按鈕間距 15px+

### 導航系統
* **統一導航列**：商城、背包、冒險、登出按鈕
* **麵包屑**：顯示當前頁面位置
* **快速跳轉**：點數、壽命即時顯示

---

# 📋 前端頁面詳細規格

## 🔐 login.html
### 功能需求
* 古風登入表單設計
* 帳號/密碼驗證欄位
* 記住密碼功能
* 登入狀態檢查

### 技術實作
* `fetch()` POST 請求至 `login.php`
* JSON 格式回傳處理
* 成功後跳轉至 `shop.html`
* 錯誤訊息友善顯示

## 📝 register.html
### 功能需求
* 註冊表單：帳號、密碼、確認密碼、暱稱
* 即時表單驗證
* 帳號重複檢查
* 密碼強度檢測

### 驗證規則
* 帳號：4-20字元，英數字組合
* 密碼：6-30字元，包含英文+數字
* 暱稱：2-10字元，中英文皆可

## 🏪 shop.html
### 功能需求
* 商品分類篩選：武器、防具、祕笈、靈丹、全部
* 商品卡片展示：圖片、名稱、屬性、價格
* 即時點數顯示與同步
* 購買確認對話框
* 購買成功動畫效果

### 商品資訊展示
* 攻擊值、防禦值、等級
* 特殊效果說明
* 庫存狀態
* 推薦標籤

## 🎒 inventory.html
### 功能需求
* 裝備分類展示
* 裝備屬性統計
* 道具使用功能
* 數量管理系統

### 統計資訊
* 總攻擊力、總防禦力
* 裝備等級分布
* 道具數量統計
* 獲得時間排序

## 📖 story.html
### 遊戲介面
* 劇情文字區域
* 選項按鈕區域 (自動換行)
* 角色狀態欄：點數、壽命、裝備
* 右下角「修仙小提示」浮動區塊

### 互動功能
* 劇情選擇系統
* 隨機事件觸發
* 結局判定系統
* 存檔/讀檔功能

---

# 🖥️ 後端架構

## 🔧 技術規格
* **語言**：PHP 7.4+
* **資料庫**：MySQL 8.0+
* **會話管理**：PHP Sessions
* **API格式**：RESTful JSON API

## 🛡️ 安全機制
* **SQL注入防護**：Prepared Statements
* **XSS防護**：htmlspecialchars() 過濾
* **CSRF防護**：Token驗證
* **Session安全**：httponly、secure flags

## 📡 API 端點規格

### config.php
```php
// 資料庫連線配置
// 錯誤處理設定
// 安全性設定
```

### login.php
**輸入**：username, password
**輸出**：JSON {success: bool, message: string, member_id: int}
**功能**：驗證登入、建立Session

### register.php
**輸入**：username, password, nickname
**輸出**：JSON {success: bool, message: string}
**功能**：新增會員、初始化數據

### shop.php
**GET**：取得商品列表（支援分類篩選）
**POST**：購買商品（member_id, product_id, quantity）
**輸出**：JSON {success: bool, message: string, data: array}

### inventory.php
**GET**：取得會員背包清單
**輸出**：JSON {success: bool, data: array, stats: object}

### story.php
**GET**：取得當前劇情狀態
**POST**：處理劇情選擇
**功能**：隨機事件、結局判定、壽命扣除

### add_points.php
**POST**：安全增減點數（amount, type）
**輸出**：JSON {success: bool, new_points: int}

### use_item.php
**POST**：使用道具（member_id, product_id）
**輸出**：JSON {success: bool, effect: string}

---

# 📊 資料庫設計

## 1️⃣ members (會員資料表)
| 欄位 | 型別 | 約束 | 說明 |
|------|------|------|------|
| member_id | INT | PK, AUTO_INCREMENT | 會員編號 |
| username | VARCHAR(50) | UNIQUE, NOT NULL | 登入帳號 |
| password | VARCHAR(255) | NOT NULL | 密碼 (bcrypt) |
| nickname | VARCHAR(50) | NOT NULL | 遊戲暱稱 |
| points | INT | DEFAULT 1000 | 商城點數 |
| lifespan | INT | DEFAULT 100 | 壽命值 |
| level | INT | DEFAULT 1 | 修仙等級 |
| experience | INT | DEFAULT 0 | 經驗值 |
| last_login | DATETIME | NULL | 最後登入時間 |
| created_at | DATETIME | DEFAULT CURRENT_TIMESTAMP | 註冊時間 |
| updated_at | DATETIME | ON UPDATE CURRENT_TIMESTAMP | 更新時間 |

## 2️⃣ products (商品資料表)
| 欄位 | 型別 | 約束 | 說明 |
|------|------|------|------|
| product_id | INT | PK, AUTO_INCREMENT | 商品編號 |
| name | VARCHAR(100) | NOT NULL | 商品名稱 |
| type | ENUM('武器','防具','祕笈','靈丹','特殊') | NOT NULL | 商品類型 |
| attack | INT | DEFAULT 0 | 攻擊值 |
| defense | INT | DEFAULT 0 | 防禦值 |
| level | INT | DEFAULT 1 | 裝備等級 |
| price | INT | NOT NULL | 價格 |
| effect | TEXT | NULL | 特殊效果 |
| rarity | ENUM('普通','稀有','傳說','神話') | DEFAULT '普通' | 稀有度 |
| image | VARCHAR(255) | NULL | 商品圖片 |
| description | TEXT | NULL | 商品描述 |
| stock | INT | DEFAULT -1 | 庫存數量 (-1=無限) |
| is_active | BOOLEAN | DEFAULT TRUE | 是否上架 |
| created_at | DATETIME | DEFAULT CURRENT_TIMESTAMP | 建立時間 |

## 3️⃣ inventory (背包資料表)
| 欄位 | 型別 | 約束 | 說明 |
|------|------|------|------|
| inventory_id | INT | PK, AUTO_INCREMENT | 背包記錄編號 |
| member_id | INT | FK, NOT NULL | 會員編號 |
| product_id | INT | FK, NOT NULL | 商品編號 |
| quantity | INT | DEFAULT 1 | 數量 |
| is_equipped | BOOLEAN | DEFAULT FALSE | 是否裝備中 |
| acquired_at | DATETIME | DEFAULT CURRENT_TIMESTAMP | 獲得時間 |

## 4️⃣ story_progress (劇情進度表)
| 欄位 | 型別 | 約束 | 說明 |
|------|------|------|------|
| progress_id | INT | PK, AUTO_INCREMENT | 進度編號 |
| member_id | INT | FK, NOT NULL | 會員編號 |
| current_chapter | INT | DEFAULT 1 | 當前章節 |
| current_scene | INT | DEFAULT 1 | 當前場景 |
| death_count | INT | DEFAULT 0 | 死亡次數 |
| ending_type | VARCHAR(50) | NULL | 結局類型 |
| save_data | JSON | NULL | 存檔數據 |
| created_at | DATETIME | DEFAULT CURRENT_TIMESTAMP | 建立時間 |
| updated_at | DATETIME | ON UPDATE CURRENT_TIMESTAMP | 更新時間 |

## 🔗 外鍵約束
```sql
ALTER TABLE inventory ADD CONSTRAINT fk_inventory_member 
  FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE;
  
ALTER TABLE inventory ADD CONSTRAINT fk_inventory_product 
  FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE;
  
ALTER TABLE story_progress ADD CONSTRAINT fk_story_member 
  FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE;
```

---

# 🎮 遊戲機制設計

## ⚔️ 戰鬥系統
### 屬性計算
* **總攻擊力** = 基礎攻擊 + 裝備攻擊力加成
* **總防禦力** = 基礎防禦 + 裝備防禦力加成
* **存活率** = 50% + (總攻擊力 + 總防禦力) * 0.5%

### 死亡機制
* 每次事件消耗壽命：10-30點（隨機）
* 壽命≤0時觸發死亡判定
* 裝備越強，死亡率越低
* 特殊道具可復活或免死

## 🏆 等級系統
### 修仙境界
1. **練氣期** (Lv.1-10)：初入修仙
2. **築基期** (Lv.11-20)：修為小成
3. **金丹期** (Lv.21-30)：修為大成
4. **元嬰期** (Lv.31-40)：修為精深
5. **化神期** (Lv.41-50)：修為通天
6. **飛昇期** (Lv.51+)：羽化登仙

### 經驗值獲得
* 完成劇情：+10-50 exp
* 戰勝敵人：+20-100 exp
* 使用祕笈：+5-20 exp
* 特殊事件：+100-500 exp

## 🎲 隨機事件系統
### 事件類型
* **正面事件**：獲得點數、裝備、經驗
* **負面事件**：失去點數、壽命、裝備
* **中性事件**：劇情推進、選擇分支
* **特殊事件**：稀有道具、隱藏劇情

### 事件權重
* 正面事件：40%
* 負面事件：35%
* 中性事件：20%
* 特殊事件：5%

## 🏁 結局系統
### 結局類型
* **飛昇結局**：達到飛昇期 + 特定條件
* **死亡結局**：壽命耗盡 + 復活道具用完
* **隱退結局**：達到特定點數 + 使用結局券
* **魔道結局**：選擇特定劇情分支
* **仙道結局**：正道路線 + 高等級
* **隱藏結局**：特殊條件觸發

---

# 🛒 商城商品設定

## ⚔️ 武器類
| 名稱 | 攻擊 | 防禦 | 等級 | 價格 | 稀有度 |
|------|------|------|------|------|--------|
| 木劍 | 10 | 0 | 1 | 100 | 普通 |
| 鐵劍 | 25 | 5 | 2 | 300 | 普通 |
| 青鋼劍 | 45 | 10 | 3 | 600 | 稀有 |
| 七星劍 | 70 | 15 | 4 | 1000 | 稀有 |
| 屠龍刀 | 100 | 20 | 5 | 2000 | 傳說 |
| 軒轅神劍 | 150 | 30 | 6 | 5000 | 神話 |

## 🛡️ 防具類
| 名稱 | 攻擊 | 防禦 | 等級 | 價格 | 稀有度 |
|------|------|------|------|------|--------|
| 布衣 | 0 | 15 | 1 | 100 | 普通 |
| 皮甲 | 5 | 30 | 2 | 300 | 普通 |
| 鎖子甲 | 10 | 50 | 3 | 600 | 稀有 |
| 紫霞仙袍 | 15 | 80 | 4 | 1200 | 稀有 |
| 龍鱗甲 | 25 | 120 | 5 | 2500 | 傳說 |
| 混沌戰甲 | 40 | 200 | 6 | 6000 | 神話 |

## 📜 祕笈類
| 名稱 | 攻擊 | 防禦 | 等級 | 價格 | 特殊效果 |
|------|------|------|------|------|----------|
| 基礎心法 | 20 | 20 | 1 | 500 | 經驗值+20% |
| 太極心法 | 40 | 40 | 2 | 1000 | 經驗值+40% |
| 九陽真經 | 80 | 60 | 3 | 2500 | 經驗值+60% |
| 易筋經 | 100 | 100 | 4 | 4000 | 經驗值+80% |
| 神照經 | 150 | 120 | 5 | 8000 | 經驗值+100% |

## 💊 靈丹類
| 名稱 | 效果 | 價格 | 說明 |
|------|------|------|------|
| 回春丹 | 壽命+30 | 200 | 回復少量壽命 |
| 大還丹 | 壽命+50 | 400 | 回復中量壽命 |
| 九轉金丹 | 壽命+100 | 1000 | 回復大量壽命 |
| 不老丹 | 壽命+200 | 3000 | 回復超量壽命 |
| 不死藥 | 復活+滿壽命 | 10000 | 死亡時自動復活 |

## 🎁 特殊道具
| 名稱 | 效果 | 價格 | 說明 |
|------|------|------|------|
| 結局券 | 隨機結局 | 5000 | 可選擇特定結局 |
| 經驗丹 | 經驗+500 | 800 | 大量經驗值 |
| 幸運符 | 好運+1天 | 1500 | 提升正面事件機率 |
| 時光石 | 回到過去 | 8000 | 重置劇情進度 |
| 傳送符 | 跳躍章節 | 3000 | 快速推進劇情 |

---

# 📱 前端 JavaScript 規範

## 🔧 核心功能
```javascript
// 全域變數
let currentUser = null;
let gameState = {};

// API 呼叫封裝
async function apiCall(endpoint, method = 'GET', data = null) {
    // 統一的 API 呼叫處理
}

// 頁面初始化
function initPage() {
    // 檢查登入狀態
    // 載入頁面資料
    // 綁定事件監聽
}

// 即時數據更新
function updateUserStats() {
    // 更新點數、壽命、等級顯示
}
```

## 🎨 UI 交互效果
* 按鈕點擊動畫
* 載入中效果
* 成功/失敗提示
* 平滑頁面轉場
* 響應式選單

---

# ✅ 開發檢查清單

## 🛠️ 開發階段
- [ ] 資料庫結構建立
- [ ] 後端 API 開發
- [ ] 前端頁面製作
- [ ] 樣式設計實作
- [ ] 功能測試
- [ ] 安全性檢查

## 🧪 測試階段
- [ ] 會員註冊/登入測試
- [ ] 商城購買功能測試
- [ ] 背包系統測試
- [ ] 劇情系統測試
- [ ] 響應式設計測試
- [ ] 跨瀏覽器相容性測試

## 🚀 部署階段
- [ ] 生產環境配置
- [ ] 資料庫部署
- [ ] 安全性設定
- [ ] 效能優化
- [ ] 備份機制建立

---

# 📚 技術文件

## 🔍 除錯指南
* 開啟瀏覽器開發者工具
* 檢查 Console 錯誤訊息
* 確認 Network 請求狀態
* 驗證 Session 資料

## 📋 常見問題
* **登入失敗**：檢查帳號密碼、資料庫連線
* **點數不同步**：確認 Session 有效性
* **商品購買失敗**：檢查點數餘額、庫存狀態
* **劇情無法推進**：確認事件邏輯、資料庫更新

## 🎯 效能優化
* 使用 CDN 載入外部資源
* 壓縮 CSS/JS 檔案
* 優化資料庫查詢
* 實作快取機制

---

**最後更新：2024年**  
**版本：v2.0**  
**開發者：修仙工作室**
