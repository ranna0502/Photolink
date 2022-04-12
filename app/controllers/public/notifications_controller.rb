class Public::NotificationsController < ApplicationController

  def index
    # 自分宛の通知を代入する
    @notifications = current_user.passive_notifications
    @notifications.where(is_checked: false).each do |notification|
      # update_attributesは廃止のため使用禁止
      notification.update(is_checked: true)
    end
  end

end
