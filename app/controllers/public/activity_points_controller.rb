class Public::ActivityPointsController < ApplicationController
  before_action :set_activity_point, only: [:user_record]

  def new
    @activity_point = ActivityPoint.new
    @user = current_user
  end

  def user_record
    @user = current_user
    # ログインユーザーが最後に記録したデータを取得
    @activity_point = @user.activity_points.last
  end

  def edit
    @activity_point = ActivityPoint.find(params[:id])
    @user = current_user
    # ログインユーザー以外編集できない
    if @activity_point.user != current_user
      redirect_to user_path(@user), alert: '編集できません'
    end
  end

  def update
    @activity_point = ActivityPoint.find(params[:id])
    if @activity_point.update(activity_point_params)
      redirect_to user_path(current_user), notice: "活動地点を更新しました"
    else
      @user = current_user
      render "edit", alert: "活動地点の保存に失敗しました"
    end
  end

  def destroy
    @activity_point = ActivityPoint.find(params[:id])
    @activity_point.destroy
    redirect_to new_activity_point_path
  end

  def create
    @activity_point = ActivityPoint.new(activity_point_params)
    @activity_point.user_id = current_user.id
    activity_point_count = ActivityPoint.where(user_id: current_user.id).count # 投稿数をカウント
    if activity_point_count < 1
      if @activity_point.save
        redirect_to user_path(current_user), notice: "活動登録しました"
      else
        @user = current_user
        render 'new', alert: "活動地点の保存に失敗しました"
      end
    else
      redirect_to new_activity_point_path, notice: "活動登録は１回までです。地点を変更する場合は編集より行ってください"
    end
  end

  def search
    @user = current_user
    # 検索オブジェクト
    @search = ActivityPoint.ransack(params[:q])
    # 検索結果
    @activity_points = @search.result(distinct: true).page(params[:page]).per(5)
    # 検索結果の最初の１つだけデータ取得
    @activity_point = @activity_points.first
  end

  private

  def activity_point_params
    params.require(:activity_point).permit(:date, :time, :person, :spot, :prefecture, :address, :request, :activity_status, :latitude, :longitude)
  end

  # ログインユーザーがデータを登録しているか確認
  def set_activity_point
    unless ActivityPoint.exists?(user_id: current_user.id)
      redirect_to new_activity_point_path, notice: "まずは活動地点を登録してみましょう！"
    end
  end

  # URLを直接入力されても遷移しない
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.nickname == "guestuser"
      redirect_to user_path(current_user), notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end
