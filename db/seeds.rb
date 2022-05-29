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
    {email: 'foo@foo', nickname: 'ふーちゃん', introduction: '家族旅行に良く行きます♪', password: '111111', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/couple1.jpeg"), filename:"couple1.jpeg")}
  ]
)

ActivityPoint.create!(
  [
    {time: '13:00',date: '2022/5/10', person: '1',spot: 'スカイツリー',prefecture: '東京都',address: '墨田区押上1丁目1-2',latitude: 35.710256,longitude: 139.8107946,activity_status: 0,request: 'スカイツリー周辺散策予定です。写真を撮る練習がしたいです！', user_id: 1 },
    {time: '13:30',date: '2022/5/10', person: '3',spot: '浅草寺雷門',prefecture: '東京都',address: '台東区浅草2丁目3-1',latitude: 35.7135505,longitude: 139.7967195,activity_status: 1,request: '東京旅行中です。浅草で友達と写真撮って欲しいです', user_id: 2 },
    {time: '15:00',date: '2022/5/12', person: '1',spot: '東京駅',prefecture: '東京都',address: '千代田区丸の内1丁目',latitude: 35.685698,longitude: 139.770577,activity_status: 0,request: '東京駅で写真撮って欲しい方いませんか？', user_id: 3 },
    {time: '10:00',date: '2022/5/5', person: '3',spot: 'あべのハルカス',prefecture: '大阪府',address: '大阪市阿倍野区阿倍野筋1丁目1-43',latitude: 34.6459521,longitude: 135.5139735,activity_status: 0,request: '天王寺周辺でフォトウォーク中です！写真撮って欲しい方はぜひ！', user_id: 4 },
    {time: '11:30',date: '2022/5/5', person: '2',spot: '通天閣',prefecture: '大阪府',address: '大阪市浪速区恵美須東1丁目18-6',latitude: 34.6525256,longitude: 135.5063765,activity_status: 1,request: '旅行中です！ペットと一緒に撮っていただけませんか', user_id: 5 },
    {time: '14:00',date: '2022/5/10', person: '4',spot: '天王寺動物園',prefecture: '大阪府',address: '大阪市天王寺区茶臼山町1-108',latitude: 34.6513486,longitude: 135.5103965,activity_status: 1,request: '家族で動物園にいきます！家族写真が撮りたいです', user_id: 6 }
  ]
)

# リレーションシップのサンプルを追加
# usersにすべてのユーザーを代入
users = User.all
# userにUserテーブルの1番目のユーザーを代入
user  = users[0]
# usersの2番目～6番目を代入
following = users[1..5]
followers = users[1..5]
# followingを順に取り出してブロック内を実行
# 取り出した要素をfollowedに代入　userがfollowedをフォロー
following.each { |followed| user.follow(followed) }
# followersを順に取り出してブロック内を実行
# 取り出した要素をfollowerに代入　followerがユーザーをフォロー
followers.each { |follower| follower.follow(user) }