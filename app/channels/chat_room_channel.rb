class ChatRoomChannel < ApplicationCable::Channel
  def subscribed
    # どのチャネルを購読するか指定
    # これによりchat_room_channel.jsとデータ送受信を行う
    stream_from "chat_room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
    
    # chat_room_channel.jsで実行されたspeakアクションのchat_messageを受け取る
    # chat_room_channel.jsのreceivedメソッドにdataを送信する
  def speak(data)
    ChatMessage.create!(
      content: data['chat_message'],
      user_id: current_user.id,
      chat_room_id: data['chat_room_id']
    )
  end
end
