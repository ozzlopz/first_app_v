class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
    helper_method :current_user, :logged_in?, :character_count#(field_id, update_id, options = {})
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "Para realizar esa acción debes tener una sesión iniciada"
      redirect_to offers_path
    end
  end
end
