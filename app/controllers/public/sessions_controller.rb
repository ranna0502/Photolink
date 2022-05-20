# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  protected

  # 退会しているかを判断するメソッド
  def user_state
    @user = User.find_by(email: params[:user][:email]) ## 【処理1】 emailからアカウントを1件取得
    return if !@user # アカウントを取得できなかった場合、このメソッドを終了
    if @user.valid_password?(params[:user][:password]) ## 【処理2】 取得したアカウントのパスワードと入力されたパスワードが一致してるか判別
      if @user.is_deleted == true ## 【処理3】
        redirect_to new_user_registration_path, notice: "退会済みです。再度ご登録をしてご利用ください。"
      else
        sign_in @user
      end
    end
  end

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end
