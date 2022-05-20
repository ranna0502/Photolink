class Notification < ApplicationRecord
  belongs_to :chat_message, optional: true

  belongs_to :visitor, class_name: 'User', optional: true
  belongs_to :visited, class_name: 'User', optional: true
end
