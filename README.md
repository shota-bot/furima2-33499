# README
# テーブル設計

<!-- ユーザー管理 -->
## users テーブル
| Column             | Type   | Option      |
| -------------------| -------| ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birthday           | date   | null: false |

## Association
- has_many :items
- has_many :orders
- has_many :comments
- has_many :likes
- has_many :reports


<!-- 住所 -->
## addresses テーブル
| Column         | Type       | Option                         |
| -------------- | ---------- | ------------------------------ |
| postal_code    | string     | null: false                    |
| prefecture_id  | integer    | null: false                    |
| city           | string     | null: false                    |
| house_num      | string     | null: false                    |
| building       | string     |                                |
| phone_num      | string     | null: false                    |
| order          | references | null: false, foreign_key: true |

## Association
- belongs_to :order

<!-- 出品管理 -->
## items テーブル
| Column         | Type       | Option                         |
| -------------- | ---------- | ------------------------------ |
| name           | string     | null: false                    |
| text           | text       | null: false                    |
| postage_id     | integer    | null: false                    |
| prefectures_id | integer    | null: false                    |
| day_id         | integer    | null: false                    |
| price          | integer    | null: false                    |
| user           | references | null: false, foreign_key: true |
| category_id    | integer    | null: false                    |
| status_id      | integer    | null: false                    |

## Association
- belongs_to :user
- has_many :comments
- has_many :likes
- has_many :reports
- has_one :order


<!-- 購入管理 -->
## orders テーブル
| Column  | Type       | Option                         |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |

## Association
- belongs_to :user
- belongs_to :item
- has_one :address