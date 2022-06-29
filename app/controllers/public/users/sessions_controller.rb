class Public::Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    # guestメソッドを呼ぶ
    user = User.guest
    sign_in user
    redirect_to user_path(user), notice: 'guestuserでログインしました。'
  end
end

