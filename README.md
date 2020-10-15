## アプリ名
SUGU

## 概要
このアプリでは、「今」時間が空いている異性とすぐに合コンをすることができるアプリです。

## 本番環境
デプロイ先 : https://sugu-sugu.herokuapp.com/

テストアカウント① &nbsp;**email** : test1@test.test &nbsp;  **password** : aaaa11

テストアカウント② &nbsp;**email** : test2@test.test &nbsp;  **password** : aaaa11


## 制作背景
私はナンパをするのが苦手です。  
私は営業マン時代、仕事終わりに上司によく繁華街に連れていってもらっていました。1軒目を出た後に、上司は必ず「ナンパしてこい。」と私を促します。上司は異性とお酒を飲みたいのです。しかし私はナンパが得意ではなく、失敗ばかりでした。このような経験から、ナンパをするのは非常に嫌なことでした。  
そこで、このアプリを制作いたしました。これさえあれば、直接女性に声をかけることなくチャットをするだけで女性と食事をすることができます。

## DEMO
トップページhttps://i.gyazo.com/320571ba00a18236fce838bb88dbb3db.mp4  

ログイン画面https://i.gyazo.com/94d141b274268c25446622858b59bf6a.jpg  

お気に入り機能https://i.gyazo.com/5238508030a286854b93486389328769.mp4  

チャットルーム作成https://i.gyazo.com/8cf5f39a17f120d9f426f6f23d864be3.mp4  

チャット機能https://i.gyazo.com/58b7bcbb45fefacbf220ab8b1a5420bd.mp4
 
## 工夫したポイント
マッチング機能の作成を工夫しました。  
このアプリでのマッチングの定義は、「ユーザー達がお互いの投稿した情報に対してお気に入りをする」ということです。Twitterで例えると、ユーザーAがユーザーBのツイートにお気に入りを、ユーザーBがユーザーAのツイートにお気に入りをした状態です。これをコードで表すことに注力しました。具体的には、DBからデータを取り出す方法をいくつも調べ、何個も実践しました。  
その結果が下記のコードです。
```ruby
x = current_user.favorite_user_infos.pluck(:user_id)
y = current_user.user_info.favorite_users.ids
z = x & y
@match = User.where(id: z)
```
ネットにはマッチングさせる方法などのような記事はなく、自力でこのコードまでたどり着けたということにとても自信を持つことができました。
## 使用技術(開発環境)
【言語】
HTML5、CSS3、Ruby、JavaScript  

【OS】
macOS  

【DB】
Sequel Pro  

【フレームワーク】
Ruby on Rails

## 課題や今後実装したい機能
課題は、マッチしたユーザーとチャットをするために、チャットルームを作成しなければいけないことです。  
これがあることでユーザビリティが低くなってしまいます。現段階の技術力ではこれを解消することができませんでした。
今後実装したい機能は、メッセージの非同期通信です。

## DB設計
### users テーブル

| Column             | Type    | Options     |
| ------------------ | ------- | ----------- |
| nickname           | string  | null: false |
| gender             | string  | null: false |
| email              | string  | null: false |
| password           | string  | null: false |

#### Association

- has_one   :user_info
- has_many  :favorites, dependent: :destroy
- has_many  :favarite_user_infos, through: :favorites, source: :user_info
- has_many  :rooms, through: :room_users
- has_many  :room_users
- has_many  :messages





### user_infos テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| text             | text       | null: false                    |
| people_num_id    | integer    | null: false                    |
| area_id          | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |

#### Association

- belongs_to             :user
- has_one_attached       :image 
- has_many               :favorites, dependent: :destroy
- has_many               :favorite_users, through: :favorites, source: :user
- belongs_to_active_hash :area
- belongs_to_active_hash :people_num


###  rooms テーブル
| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |

#### Association
- has_many   :room_users
- has_many   :users, through: room_users
- has_many   :messages




### room_users テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| user         | references | null: false, foreign_key: true |
| room         | references | null: false, foreign_key: true |

#### Association

- belongs_to :room
- belongs_to :user





###  favorites テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| user_id      | integer    |                                |
| user_info_id | integer    |                                |


#### Association

- belongs_to :user
- belongs_to :user_info







###  messages テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| content    | string     |                                |
| user       | references | null: false, foreign_key: true |
| room       | references | null: false, foreign_key: true |

#### Association

- belongs_to :room
- belongs_to :user





