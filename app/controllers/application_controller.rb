class ApplicationController < ActionController::Base
  
  include Authentication
  helper_method :current_user
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  around_action :switch_locale

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
 
  def authenticate_user!
    unless current_user
      redirect_to new_session_path, alert: "Bạn cần đăng nhập để tiếp tục."
    end
  end
end
