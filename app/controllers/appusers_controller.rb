class AppusersController < ApplicationController
  
  before_action :set_user, only: :show
  skip_before_action :verify_authenticity_token
  
  def index
    @appusers = Appuser.all
  end
  
  def create
    if Appuser.exists?(:email => params[:email])
      @appuser = Appuser.find_by_email(params[:email])
      @appuser.name = params[:name]
      @appuser.first_last_name = params[:first_last_name]
      @appuser.second_last_name = params[:second_last_name]
      @appuser.lada = params[:lada]
      @appuser.phone = params[:phone]
      @appuser.model = params[:model]
      @appuser.serial_number = params[:serial_number]
      @appuser.modelId = params[:modelId]
    else  
    @appuser = Appuser.create(appuser_params)
    end
    @appuser.car_id = @appuser.modelId
    @appuser.save
    render "client_confirmation"
  
  end
  
  def show
  
  end
  
  def destroy
    Appuser.find(params[:id]).destroy
    flash[:success] = "Cliente borrado exitosamente"
    redirect_to appusers_path
  end
  
  private 
    def appuser_params
      params.require(:appuser).permit(:name,:first_last_name,:second_last_name,:lada,:phone,:email,:model,:serial_number,:modelId)
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