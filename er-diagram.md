# 修仙文字遊戲 ER 圖

```mermaid
erDiagram
    members {
        INT member_id PK
        VARCHAR username
        VARCHAR password
        VARCHAR nickname
        INT points
        DATETIME created_at
    }

    products {
        INT product_id PK
        VARCHAR name
        ENUM type
        INT attack
        INT defense
        INT level
        INT price
    }

    inventory {
        INT inventory_id PK
        INT member_id FK
        INT product_id FK
        DATETIME acquired_at
    }

    members ||--o{ inventory : 擁有
    products ||--o{ inventory : 包含
```
