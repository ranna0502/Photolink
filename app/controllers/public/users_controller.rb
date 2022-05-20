class Public::UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]
  before_action :other_user, only: [:edit]

  def show
    @users = Kaminari.paginate_array(current_user.matchers).page(params[:page]).per(30)
    @user = User.find(params[:id])
    @activity_point = ActivityPoint.find_by(user_id: @user)
  end

  def edit
    @user = User.find(params[:id])
    @activity_point = ActivityPoint.find_by(user_id: @user)
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_path(@user), notice: "プロフィールを更新しました"
    else
      @activity_point = ActivityPoint.find_by(user_id: @user)
      render "edit"
    end
  end

  def matching
    @user = User.find(params[:id])
    @activity_point = @user.activity_points.last
    @relationship = Relationship.new
  end

  def matchings
    @users = Kaminari.paginate_array(current_user.matchers).page(params[:page]).per(10)
    @user = current_user
    @activity_point = ActivityPoint.find_by(user_id: @user)
  end

  def unsubscribe # 退会確認画面表示
  end

  def withdraw # 入退会ステータス更新
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: "退会処理を実行いたしました"
  end

  private

  # URLを直接入力されても遷移しない
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.nickname == "guestuser"
      redirect_to user_path(current_user), notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

  def other_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user), notice: 'プロフィール編集画面へ遷移できません。'
    end
  end

  def user_params
    params.require(:user).permit(:profile_image, :nickname, :introduction, :is_deleted, :email, :encrypted_password)
  end
end
