class LoginsController < ApplicationController
  
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
  
end
  