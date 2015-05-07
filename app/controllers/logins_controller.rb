class LoginsController < ApplicationController
  
  before_action :require_logged__user, only: :destroy
  before_action :require_unlogged__user, only: [:new,:create]
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "La sesión ha sido iniciada exitosamente"
      redirect_to offers_path
    else
      flash.now[:danger] = "La contraseña o el correo electrónico proporcionado son erróneos"
      render 'new'
    end
  end
    
  def destroy
    session[:user_id] = nil
    flash[:success] = "La sesión se ha cerrado exitosamente"
    redirect_to root_path
  end
  
  private 
    def require_logged__user
      if !logged_in?
        flash[:danger] = "Para realizar esa acción debes tener una sesión iniciada"
        redirect_to root_path
      end
    end
    
    def require_unlogged__user
      if logged_in?
        flash[:danger] = "Ya tienes iniciada una sesión"
        redirect_to root_path
      end
    end
    
  
end
  