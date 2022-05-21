class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable

  has_one_attached :profile_image
  has_many :activity_points
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :following, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships
  has_many :chat_room_users
  has_many :chat_rooms, through: :chat_room_users
  has_many :chat_messages
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  validates :nickname, presence: true
  validates :email, presence: true
  validates :introduction, length: { maximum: 255 }

  # ゲストログインメソッド
  def self.guest
    find_or_create_by!(nickname: 'guestuser', email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = "guestuser"
    end
  end

  # OAuth認証

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    User.dummy_email(auth),
        nickname: auth.name,
        password: Devise.friendly_token[0, 20]
      )
    end

    user
  end



  # 退会済みのユーザーがログインできないメソッド
  def active_for_authentication?
    super && (is_deleted == false)
  end

  # プロフィール画像取得メソッド
  def get_profile_image
    profile_image.attached? ? profile_image : 'no_image.jpg'
  end

  # フォローしているか確認するメソッド
  def following?(user)
    following_relationships.find_by(following_id: user.id)
  end

  def follower?(user)
    follower_relationships.find_by(follower_id: user.id)
  end

  # フォローする時のメソッド
  def follow(user)
    following_relationships.create!(following_id: user.id)
  end

  # ログインしているユーザーとマッチングしているユーザーを取得メソッド
  def matchers
    following & followers
  end

  # フォロー通知を作成するメソッド
  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ", current_user.id, id, 'follow'])
    # 連続でフォローボタンを押しても１回目だけを通知する
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  private

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

end
