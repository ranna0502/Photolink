class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_one_attached :profile_image
  has_many :activity_points
  has_many :active_relationships,class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :following, through: :active_relationships
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :chat_room_users
  has_many :chat_rooms, through: :chat_room_users
  has_many :chat_messages
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy


# ゲストログインメソッド
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

# プロフィール画像取得メソッド
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

#既にフォローしている人の中に存在するか確認するメソッド
  def following?(other_user)
    following.include?(other_user)
  end

#ログインしているユーザーとマッチングしているユーザーを取得メソッド
  def matchers
    following & followers
  end

end
