class ActivityPoint < ApplicationRecord

  belongs_to :user

  # ライブラリの読み込み
  include JpPrefecture

  enum activity_status: { photographer: 0, subject: 1 }
end
