class ApplicationController < ActionController::Base
  helper_method :current_user

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  rescue StandardError
    render_404
  end

  def render_404
    render file: "#{Rails.root}/public/404", status: :not_found
  end

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
