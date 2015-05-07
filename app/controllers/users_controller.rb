class UsersController < ApplicationController
  
  before_action :set_user, only: [:edit,:update,:show]
  before_action :require_logged__user
  before_action :require_same_user, only: [:edit,:update]
  before_action :admin_user, only: :new
  
  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "La cuenta ha sido creada exitosamente"
      #session[:user_id] = @user.id
      redirect_to offers_path
    else
      render 'new' 
    end
  end
  
  def edit
  
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "El perfil ha sido editado exitosamente"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end
  
  def show
    @offers = @user.offers.paginate(page: params[:page], per_page: 3)
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Usuario borrado exitosamente"
    redirect_to users_path
  end
  
  private 
    def user_params
      params.require(:user).permit(:username,:email,:password,:admin,:picture,:password_confirmation)
    end
    
    def set_user
       @user = User.find(params[:id])
    end
    
    def require_same_user
      if current_user != @user && !current_user.admin?
        flash[:danger] = "Solamente puedes editar otros perfiles con una cuenta de administrador"
        redirect_to root_path
      end
    end
    
    def admin_user
      redirect_to offers_path unless current_user.admin?
    end
    
    def require_logged__user
      if !logged_in?
        flash[:danger] = "Para realizar esa acción debes tener una sesión iniciada"
       redirect_to root_path
      end
    end
  
end