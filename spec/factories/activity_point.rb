FactoryBot.define do
  factory :activity_point do
    id { Faker::Number.between(from: 1, to: 100) } #=> 1 ~ 1000
    user_id { Faker::Number.between(from: 1, to: 100) } #=> 1 ~ 1000
    time { '11:30' } #=> 00:00:00
    date { '2022/1/1' } #=> 2022/01/01 ~ 2030/12/30
    person { Faker::Number.between(from: 1, to: 20)} #=> 1 ~ 20
    spot { Faker::Lorem.characters(number:10) } #=> 10文字生成
    prefecture { '北海道' } #=> 5文字生成
    address { Faker::Lorem.characters(number:10) } #=> 10文字生成
    activity_status { Faker::Number.between(from: 0, to: 1) } #=> ラジオボタンの選択
    request { Faker::Lorem.characters(number:30) } #=> 30文字生成
  end
end