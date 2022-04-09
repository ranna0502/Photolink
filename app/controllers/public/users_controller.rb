class Public::UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def info
    @user = current_user
  end

  def matching
    @user = User.find(params[:id])
    @relationship = Relationship.new
  end

  def matchings
    @users = current_user.matchers
  end

  def seach
    @activity_points = ActivityPoint.all

  end

  def unsubscribe #退会確認画面表示
  end

  def withdraw #入退会ステータス更新
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end



# URLを直接入力されても遷移しない
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.nickname == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

  private

    def user_params
      params.require(:user).permit(:profile_image,:last_name,:first_name,:nickname,:introduction,:is_deleted,:email,:encrypted_password)
    end

end
