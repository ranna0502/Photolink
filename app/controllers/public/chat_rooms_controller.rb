class Public::ChatRoomsController < ApplicationController
  before_action :authenticate_user!



  def create
    current_user_chat_rooms = ChatRoomUser.where(user_id: current_user.id).map(&:chat_room) #中間テーブルから自分のレコードを取得
    chat_room = ChatRoomUser.where(chat_room: current_user_chat_rooms, user_id: params[:user_id]).map(&:chat_room).first #自分がいるかつ、マッチングしたユーザーのルームを取得
    if chat_room.blank?
      chat_room = ChatRoom.create
      ChatRoomUser.create(chat_room: chat_room, user_id: current_user.id)
      ChatRoomUser.create(chat_room: chat_room, user_id: params[:user_id])
    end
    redirect_to action: :show, id: chat_room.id
  end


  def show
    @user = current_user
    @activity_point = ActivityPoint.find_by(user_id: @user)
    @users = Kaminari.paginate_array(current_user.matchers).page(params[:page]).per(30)
    @chat_room = ChatRoom.find(params[:id])
    @chat_room_user = @chat_room.chat_room_users.where.not(user_id: current_user.id).first.user #自分とマッチングしたユーザーを取得
    @chat_messages = ChatMessage.where(chat_room: @chat_room).page(params[:page]).per(20)
  end

end
