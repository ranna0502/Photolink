class ChatMessage < ApplicationRecord

  belongs_to :user, optional: true #nilを許可する
  belongs_to :chat_room, optional: true
  has_many :notifications, dependent: :destroy

  after_create_commit { ChatMessageBroadcastJob.perform_later self }

# チャットメッセージの通知メソッド
  def create_notification_chat_message!(current_user, chat_message_id)
    temp_ids = ChatMessage.select(:user_id).where(chat_room_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_chat_message!(current_user, chat_message_id, temp_id['user_id'])
    end
    #投稿者に通知を送る
    save_notification_chat_message!(current_user, chat_message_id, user_id) if temp_ids.blank?
  end

  def save_notification_chat_message!(current_user, chat_message_id, visited_id)
    # メッセージは複数回することが考えられるため、複数回通知する
    notification = current_user.active_notifications.new(
      chat_room_id: id,
      chat_message_id: chat_message_id,
      visited_id: visited_id,
      action: 'chat_message'
    )
    # 自分のメッセージは、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
