class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:twitter, :facebook]

  has_one_attached :profile_image
  has_many :activity_points
  #class_nameで参照先モデルのクラス名を明示
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :following, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships
  has_many :chat_room_users
  has_many :chat_rooms, through: :chat_room_users
  has_many :chat_messages
  #自分からの通知
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  #相手からの通知
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
  # 認証後に得られたユーザーのメールアドレスをもとにユーザー情報の取得または登録を行う
   class << self
    def find_or_create_for_oauth(auth)
      find_or_create_by!(email: User.dummy_email(auth)) do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.nickname = User.rondom_name
        user.email = User.dummy_email(auth)
        password = Devise.friendly_token[0..5]
        logger.debug password
        user.password = password
      end
    end

    # セッションに格納されたユーザー情報を補完する
    def new_with_session(params, session)
      if user_attributes = session['devise.user_attributes']
        new(user_attributes) { |user| user.attributes = params }
      else
        super
      end
    end
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
    # 通知を送信したIDがログインユーザーかつ通知を受信したIDかつactionがフォローのデータを取得
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
    
    # OAuth認証、Emailを作る
    def self.dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@example.com"
    end

    # Oauth認証、nicknameを作る
    def self.rondom_name
      "#{((0..9).to_a + ("a".."z").to_a).sample(10).join}"
    end

end
