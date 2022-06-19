import consumer from "./consumer"

// 指定のチャネルでサブスクを作成する
// この処理の中に、サーバーとのデータ送受信を実装する
const appChatRoom = consumer.subscriptions.create("ChatRoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

// サーバー側からspeakアクションでデータを受け取る
// 最終的にサイトに表示する
  received(data) {
    const chatMessages = document.getElementById('chat-messages');
    chatMessages.insertAdjacentHTML('beforeend', data['chat_message']);
  },

// chat_room_channel.rbのspeakアクションにshat_messageを送る
  speak: function(chat_message, chat_room_id) {
    return this.perform('speak', { chat_message: chat_message, chat_room_id: chat_room_id });
  }
});

// Enterキーを押した時に処理を実行する
// speakアクションを発火させる
if(/chat_rooms/.test(location.pathname)) {
  $(document).on("keydown", ".chat-room__message-form_textarea", function(e) {
    if (e.key === "Enter") {
      const chat_room_id = $('textarea').data('chat_room_id')
      appChatRoom.speak(e.target.value, chat_room_id);
      e.target.value = '';
      e.preventDefault();
    }
  })
}
