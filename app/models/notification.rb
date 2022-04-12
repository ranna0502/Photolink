class Notification < ApplicationRecord

  # 常に新しい通知からデータを取得
  default_scope -> { order(created_at: :desc) }
  belongs_to :chat_message, optional: true

  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true

end
