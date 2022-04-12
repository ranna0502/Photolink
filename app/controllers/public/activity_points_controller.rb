class Public::ActivityPointsController < ApplicationController

  def new
    @activity_point = ActivityPoint.new
    @user = current_user
  end

  def show
    @activity_point = ActivityPoint.find(params[:id])
    @user = current_user
  end



  def edit
    @activity_point = ActivityPoint.find(params[:id])

    # ログインユーザー以外編集できない
    if @activity_point.user != current_user
      redirect_to activity_point_path(@activity_point), alert: 'Warring!!'
    end
  end

  def update
    @activity_point = ActivityPoint.find(params[:id])
    if @activity_point.update(activity_point_params)
      redirect_to activity_point_path(@activity_point), notice: "You have updated book successfully."
    else
      render "edit"
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
    activity_point_count = ActivityPoint.where(user_id: current_user.id).count #投稿数をカウント
    if activity_point_count < 1
      @activity_point.save
      redirect_to activity_point_path(@activity_point), notice: "活動地点登録しました"
    elsif
      redirect_to new_activity_point_path, notice: "活動地点投稿は1日１回までです。地点を変更する場合は編集より行ってください。"
    else
      flash.now[:alert] = "活動地点の保存に失敗しました"
      render 'new'
    end

  end


  def search
    # 検索オブジェクト
    @search = ActivityPoint.ransack(params[:q])
    # 検索結果
    @activity_points = @search.result(distinct: true)

  end





  private

  def activity_point_params
    params.require(:activity_point).permit(:created_at,:person,:spot,:prefecture,:address,:request,:activity_status,:latitude,:longitude)
  end



end
