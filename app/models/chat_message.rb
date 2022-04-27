class ChatMessage < ApplicationRecord

  belongs_to :user, optional: true #nilを許可する
  belongs_to :chat_room, optional: true
  has_many :notifications, dependent: :destroy

  after_create_commit { ChatMessageBroadcastJob.perform_later self }

end
