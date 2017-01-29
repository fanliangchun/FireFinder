class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def admin_required
  	if !current_user.admin?
  		flash[:alert] = "对不起，你没有后台权限！"
  		redirect_to "/"
  	end
  end
end
