class Public::ActivityPointsController < ApplicationController
  # 活動地点登録を制限する
  before_action :activity_point_count, only: [:new]

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
  end

  def search
    @user = current_user
    # 人気活動拠点を抽出
    @activity_point_ranks = ActivityPoint.group(:spot).order('count_spot DESC').count(:spot)
    # 検索オブジェクト
    @search = ActivityPoint.ransack(params[:q])
    # 検索結果
    @activity_points = @search.result(distinct: true).page(params[:page]).per(15)
    # 検索結果の最初の１つだけデータ取得,地図画面表示の時に使用
    @activity_point = @activity_points.first
  end

  def search_spot
    # マーカーからスポットごとのユーザー情報を取得
    @spot_users = ActivityPoint.where(spot: params[:q]).page(params[:page]).per(15)
  end

  private

  def activity_point_params
    params.require(:activity_point).permit(:date, :time, :person, :spot, :prefecture, :address, :request, :activity_status, :latitude, :longitude)
  end

# 活動地点登録を１回しかできないように制限するメソッド
  def activity_point_count
    activity_point_count = ActivityPoint.where(user_id: current_user.id).count # 投稿数をカウント
    if activity_point_count >= 1
      redirect_to user_path(current_user), notice: "活動登録は１回までです。変更する場合は編集より行ってください。"
    end
  end

end



