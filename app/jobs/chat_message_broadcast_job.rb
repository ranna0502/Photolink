class ChatMessageBroadcastJob < ApplicationJob
  queue_as :default

  # ブロードキャストの処理を実行
  def perform(chat_message)
    ActionCable.server.broadcast 'chat_room_channel', chat_message: render_chat_message(chat_message)
  end

  private

# コントローラーの制約を受けずに、任意のビューテンプレートをレンダリングする
# localsオプションで、部分テンプレートで使える変数を
  def render_chat_message(chat_message)
    ApplicationController.renderer.render(partial: 'public/chat_messages/chat_message', locals: { chat_message: chat_message, current_user: chat_message.user })
  end
end
