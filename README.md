# Photolink
![スクリーンショット 2022-06-01 18 03 05](https://user-images.githubusercontent.com/80334879/171368451-a666c433-9772-48b5-85d9-414cd906ebc6.png)
## サイト概要
### サイトテーマ
写真を撮って欲しい人と撮りたい人を繋げるマッチングサービスです

### テーマを選んだ理由
**このサービスを使うことで、より快適で楽しい趣味の時間を過ごしてほしい、新たな趣味の輪を広げてほしいという想いがあります。**   
実体験の中で、「あったらいいな」という声を参考にしました。  
主に旅行・カメラという２つの趣味が関係しています。   

**◆旅行という趣味での「あったらいいな」**</br>
　・お出かけ先でみんなで写った写真を残したい </br>
　・カメラで撮影したきれいな思い出写真がほしい </br>
 
**◆カメラという趣味での「あったらいいな」** </br>
　・旅先で人物写真も撮りたい </br>
　・いろんなシチュエーションの撮影にチャレンジしたい </br>
 
これらは、写真に対する想いは違うかもしれませんが、お互いに共通している願いがあるなと気づくことができました。 
 
**それは、「素敵な１枚を残したい」という願いです。**
 
想いを繋げる事で、両者の願いを叶えることができるのではないか。  
そのような考えから、「Photo」への想いを「Link」させるマッチングサービスを考案しました。 


### ターゲットユーザ
・写真を撮ってほしい旅行客</br>
・旅先で人物写真を撮りたいカメラマン

### 主な利用シーン
・観光スポットでの写真撮影時</br>

## 実装機能一覧  
|    | 機能 | ライブラリ/備考 |  
:--:| ------------ | ----------- |    
1 | ユーザー（ログイン機能) | devise    
2 | ゲストログイン機能 |   
3 | SNSログイン機能 | devise/omniauth(FaceBook API/Twitter API)    
4 | マイページ機能 |   
5 | 活動予定拠点投稿 | enum-help,jp_prefecture    
6 | 検索機能 | ransack    
7 | ソート機能 | ransack   
8 | ランキング機能 |    
9 | mapマーカー表示機能 | API(Google Maps JavaScript API,Geocoding API)       
10 | マッチング機能 | フォロー機能にポップアップを追加    
11 | 通知機能 |   
12 | DM機能 | ActionCable    
13 | 無限スクロール機能 | jScroll,kaminari     
15 | 定時処理（バッチ処理) | whenever  
16 | テストデータの追加 | seed.rb  
17 | rails/devise日本語化 | rails-i18n
18 | コード解析 | RuboCop  
19 | 結合テスト（投稿処理） | RSpec    
20 | 自動デプロイ | Github Actions(CI/CDツール)  
21 | https設定 | Certbot  
22 | ドメイン指定 | Route53    



## 設計書
### テーブル定義書
https://docs.google.com/spreadsheets/d/1wjpJDVUP5mBLz-5Sm6fMw-g88PFann56JHCETnJM1KU/edit#gid=2145917830

### アプリケーション詳細設計
https://docs.google.com/spreadsheets/d/1OARFfdhY1hkqcnZ23-DYdgLzRSGo1PPFX_vMndFzvt4/edit#gid=2133469642

### ER図
![ER図_Photolink-ER図 drawio](https://user-images.githubusercontent.com/80334879/171387613-f34b1ffe-60d4-46f6-ab42-3c820a0fed3e.png)

### インフラ構成  
![PFサーバー構成 drawio](https://user-images.githubusercontent.com/80334879/173719854-53c3c1bb-5e72-4fc1-ba76-480f3a831e4f.png)


## 開発環境
- OS：Linux(Amazon Linux2)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## 使用素材
### canva(ロゴ作成)
https://www.canva.com/

### photo-ac(フリー素材写真)
https://www.photo-ac.com/

## 使用方法  
**ユーザー**  
新規会員登録、ゲストログイン、SNSログインをご利用ください。  

**マッチング候補のユーザーです。データの確認などにご使用ください。**  
・アカウント名:はなちゃん  
・メールアドレス:hanako@hanako  
・ログインパスワード:111111  
