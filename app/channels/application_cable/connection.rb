module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # current_userをキーとしてconnectionを識別できるようにする
    # WebSocketの接続の識別、channelでも利用可能
    identified_by :current_user
    
    # WebSocket接続が開いている場合は閉じ、404を返す
    def connect
      reject_unauthorized_connection unless find_verified_user
    end

    private
    
    # ログインしているユーザーの情報を取得する
    def find_verified_user
      self.current_user = env['warden'].user
    end
  end
end
