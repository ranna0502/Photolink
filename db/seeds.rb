# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create!(
  [
    {email: 'hanako@hanako', nickname: 'はなちゃん', introduction: '写真を撮るのが好きです🌹', password: '111111', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/girl1.jpeg"), filename:"girl1.jpeg")},
    {email: 'taro@taro', nickname: 'タロー', introduction: '友達との旅行が趣味です！', password: '111111', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/animal1.jpeg"), filename:"animal1.jpeg")},
    {email: 'daisuke@daisuke', nickname: 'daisuke', introduction: 'カメラ初心者です！', password: '111111', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/boy1.jpeg"), filename:"boy1.jpeg")},
    {email: 'jiro@jiro', nickname: 'じろう', introduction: '被写体になってくれる方募集中！', password: '111111', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/boy2.jpeg"), filename:"boy2.jpeg")},
    {email: 'wan@wan', nickname: 'ワン', introduction: '犬を飼っています🐶旅行が大好きです！', password: '111111', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/dog1.jpeg"), filename:"dog1.jpeg")},
    {email: 'foo@foo', nickname: 'ふーちゃん', introduction: '家族旅行に良く行きます♪', password: '111111', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/couple1.jpeg"), filename:"couple1.jpeg")},
    {email: 'hoge1@hoge', nickname: 'ほげちゃん', introduction: 'ダミーデータ追加用です', password: '111111'},
    {email: 'hoge2@hoge', nickname: 'ほげちゃん', introduction: 'ダミーデータ追加用です', password: '111111'},
    {email: 'hoge3@hoge', nickname: 'ほげちゃん', introduction: 'ダミーデータ追加用です', password: '111111'},
    {email: 'hoge4@hoge', nickname: 'ほげちゃん', introduction: 'ダミーデータ追加用です', password: '111111'},
    {email: 'hoge5@hoge', nickname: 'ほげちゃん', introduction: 'ダミーデータ追加用です', password: '111111'},
    {email: 'hoge6@hoge', nickname: 'ほげちゃん', introduction: 'ダミーデータ追加用です', password: '111111'},
    {email: 'hoge7@hoge', nickname: 'ほげちゃん', introduction: 'ダミーデータ追加用です', password: '111111'},
    {email: 'hoge8@hoge', nickname: 'ほげちゃん', introduction: 'ダミーデータ追加用です', password: '111111'},
    {email: 'hoge9@hoge', nickname: 'ほげちゃん', introduction: 'ダミーデータ追加用です', password: '111111'},
    {email: 'hoge10@hoge', nickname: 'ほげちゃん', introduction: 'ダミーデータ追加用です', password: '111111'},
    {email: 'hoge11@hoge', nickname: 'ほげちゃん', introduction: 'ダミーデータ追加用です', password: '111111'},
    {email: 'hoge12@hoge', nickname: 'ほげちゃん', introduction: 'ダミーデータ追加用です', password: '111111'},
    {email: 'hoge13@hoge', nickname: 'ほげちゃん', introduction: 'ダミーデータ追加用です', password: '111111'},
    {email: 'hoge14@hoge', nickname: 'ほげちゃん', introduction: 'ダミーデータ追加用です', password: '111111'},
    {email: 'hoge15@hoge', nickname: 'ほげちゃん', introduction: 'ダミーデータ追加用です', password: '111111'},
    {email: 'hoge16@hoge', nickname: 'ほげちゃん', introduction: 'ダミーデータ追加用です', password: '111111'}
  ]
)

# バッチ処理で消えてしまうので１年後を設定しておくこと！（前日になると消える）
ActivityPoint.create!(
  [
    {time: '13:00',date: '2023/5/10', person: '1',spot: 'スカイツリー',prefecture: '東京都',address: '墨田区押上1丁目1-2',activity_status: 0,request: 'スカイツリー周辺散策予定です。写真を撮る練習がしたいです！', user_id: 1 },
    {time: '13:30',date: '2023/5/10', person: '3',spot: '浅草寺雷門',prefecture: '東京都',address: '台東区浅草2丁目3-1',activity_status: 1,request: '東京旅行中です。浅草で友達と写真撮って欲しいです', user_id: 2 },
    {time: '15:00',date: '2023/5/12', person: '1',spot: '東京駅',prefecture: '東京都',address: '千代田区丸の内1丁目',activity_status: 0,request: '東京駅で写真撮って欲しい方いませんか？', user_id: 3 },
    {time: '10:00',date: '2023/5/5', person: '3',spot: 'あべのハルカス',prefecture: '大阪府',address: '大阪市阿倍野区阿倍野筋1丁目1-43',activity_status: 0,request: '天王寺周辺でフォトウォーク中です！写真撮って欲しい方はぜひ！', user_id: 4 },
    {time: '11:30',date: '2023/5/5', person: '2',spot: '通天閣',prefecture: '大阪府',address: '大阪市浪速区恵美須東1丁目18-6',activity_status: 1,request: '旅行中です！ペットと一緒に撮っていただけませんか', user_id: 5 },
    {time: '14:00',date: '2023/5/10', person: '4',spot: '天王寺動物園',prefecture: '大阪府',address: '大阪市天王寺区茶臼山町1-108',activity_status: 1,request: '家族で動物園にいきます！家族写真が撮りたいです', user_id: 6 },
    {time: '15:00',date: '2023/5/14', person: '1',spot: '大阪城',prefecture: '大阪府',address: '大阪府大阪市中央区大阪城1-1',activity_status: 1,request: 'ダミーデータ追加用です', user_id: 7 },
    {time: '10:00',date: '2023/5/15', person: '1',spot: '海遊館',prefecture: '大阪府',address: '大阪府大阪市港区海岸通1丁目1−10',activity_status: 1,request: 'ダミーデータ追加用です', user_id: 8 },
    {time: '11:00',date: '2023/5/15', person: '1',spot: 'スカイビル',prefecture: '大阪府',address: '大阪府大阪市北区大淀中1丁目1-88',activity_status: 1,request: 'ダミーデータ追加用です', user_id: 9 },
    {time: '12:00',date: '2023/5/15', person: '1',spot: '中之島公園',prefecture: '大阪府',address: '大阪府大阪市北区中之島1丁目1',activity_status: 1,request: 'ダミーデータ追加用です', user_id: 10 },
    {time: '13:00',date: '2023/5/20', person: '1',spot: 'USJ',prefecture: '大阪府',address: '大阪府大阪市此花区桜島2丁目1-33',activity_status: 1,request: 'ダミーデータ追加用です', user_id: 11 },
    {time: '14:30',date: '2023/6/5', person: '1',spot: '東京タワー',prefecture: '東京都',address: '東京都港区芝公園4丁目2-8',activity_status: 1,request: 'ダミーデータ追加用です', user_id: 12 },
    {time: '15:30',date: '2023/6/10', person: '1',spot: '明治神宮',prefecture: '東京都',address: '東京都渋谷区代々木神園町1-1',activity_status: 1,request: 'ダミーデータ追加用です', user_id: 13 },
    {time: '16:00',date: '2023/7/10', person: '1',spot: '新宿御苑',prefecture: '東京都',address: '東京都新宿区内藤町11',activity_status: 1,request: 'ダミーデータ追加用です', user_id: 14 },
    {time: '17:00',date: '2023/7/15', person: '1',spot: 'アクアパーク品川',prefecture: '東京都',address: '東京都港区高輪4丁目10-30',activity_status: 1,request: 'ダミーデータ追加用です', user_id: 15 },
    {time: '18:00',date: '2023/7/20', person: '1',spot: '井の頭池',prefecture: '東京都',address: '東京都三鷹市井の頭4丁目1',activity_status: 1,request: 'ダミーデータ追加用です', user_id: 16 },
    {time: '18:00',date: '2023/7/20', person: '1',spot: 'スカイツリー',prefecture: '東京都',address: '墨田区押上1丁目1-2',activity_status: 1,request: 'ダミーデータ追加用です', user_id: 17 },
    {time: '18:00',date: '2023/7/20', person: '1',spot: 'スカイツリー',prefecture: '東京都',address: '墨田区押上1丁目1-2',activity_status: 1,request: 'ダミーデータ追加用です', user_id: 18 },
    {time: '18:00',date: '2023/7/20', person: '1',spot: 'スカイツリー',prefecture: '東京都',address: '墨田区押上1丁目1-2',activity_status: 1,request: 'ダミーデータ追加用です', user_id: 19 },
    {time: '18:00',date: '2023/7/20', person: '1',spot: 'あべのハルカス',prefecture: '大阪府',address: '大阪市阿倍野区阿倍野筋1丁目1-43',activity_status: 1,request: 'ダミーデータ追加用です', user_id: 20 },
    {time: '18:00',date: '2023/7/20', person: '1',spot: 'あべのハルカス',prefecture: '大阪府',address: '大阪市阿倍野区阿倍野筋1丁目1-43',activity_status: 1,request: 'ダミーデータ追加用です', user_id: 21 },
    {time: '18:00',date: '2023/7/20', person: '1',spot: '東京駅',prefecture: '東京都',address: '千代田区丸の内1丁目',activity_status: 1,request: 'ダミーデータ追加用です', user_id: 22 }
  ]
)

# リレーションシップのサンプルを追加
# usersにすべてのユーザーを代入
users = User.all
# userにUserテーブルの1番目のユーザーを代入
user  = users[0]
# usersの2番目～を代入
following = users[1..10]
followers = users[1..10]
# followingを順に取り出してブロック内を実行
# 取り出した要素をfollowedに代入　userがfollowedをフォロー
following.each { |followed| user.follow(followed) }
# followersを順に取り出してブロック内を実行
# 取り出した要素をfollowerに代入　followerがユーザーをフォロー
followers.each { |follower| follower.follow(user) }


