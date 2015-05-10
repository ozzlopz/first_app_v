class AppusersController < ApplicationController
  
  before_action :set_user, only: :show
  before_action :require_logged__user, only: [:index,:show,:destroy]
  skip_before_action :verify_authenticity_token
  
  def index
    @appusers = Appuser.paginate(page: params[:page], per_page: 3)
  end
  
  def new
    @appuser = Appuser.new
  end
  
  def create
    @appuser = Appuser.new(user_params)
    @appuser.save
    redirect_to appusers_path
  end
  
  def show
  
  end
  
  def destroy
    Appuser.find(params[:id]).destroy
    flash[:success] = "Cliente borrado exitosamente"
    redirect_to appusers_path
  end
  
  private 
    def user_params
      params.require(:appuser).permit(:name,:first_last_name,:second_last_name,:lada,:phone,:email,:model,:serial_number)
    end
    
    def set_user
       @appuser = Appuser.find(params[:id])
    end
    
    def require_logged__user
      if !logged_in?
        flash[:danger] = "Para realizar esa acción debes tener una sesión iniciada"
       redirect_to root_path
      end
    end
  
end