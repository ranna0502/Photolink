class ActivityPoint < ApplicationRecord

  belongs_to :user
  # ライブラリの読み込み
  include JpPrefecture

  validates :time, presence: true
  validates :date, presence: true
  validates :person, presence: true
  validates :spot, presence: true
  validates :prefecture, presence: true
  validates :address, presence: true
  validates :activity_status, presence: true
  validates :request, presence: true, length: { maximum: 200 }

  enum activity_status: { photographer: 0, subject: 1 }
end
