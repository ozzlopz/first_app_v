class AppusersController < ApplicationController
  require 'axlsx'
  
  before_action :set_user, only: :show
  skip_before_action :verify_authenticity_token
  
  def index
    @appusers = Appuser.all
    
    respond_to do |format|
      format.html
      format.xlsx do
        
        
        Axlsx::Package.new do |my_axlsx_package|
          my_axlsx_package.workbook do |wb|
            wb.add_worksheet(name:'foo') do |sheet|
              header_style = sheet.styles.add_style(:bg_color => "00", :fg_color => "FF", :b => true, :alignment => { :horizontal => :center })
              content_style = sheet.styles.add_style(:bg_color => "FF", :fg_color => "00", :b => false, :alignment => { :horizontal => :center },:border=>Axlsx::STYLE_THIN_BORDER)
              sheet.add_row ["ID","Nombre","Apellido Paterno","Apellido Materno","Teléfono de Contacto","Correo Electrónico","Modelo del Vehículo","Año del Vehículo","Número de Serie"], :style=>header_style
              @appusers.each do |appuser|
              sheet.add_row [appuser.id,appuser.name,appuser.first_last_name,appuser.second_last_name,"("+appuser.lada+")"+appuser.phone,appuser.email,appuser.model,appuser.year,appuser.serial_number], :types => [:string], :style=>content_style 
              end
            end
          end
          send_data my_axlsx_package.to_stream.read, :filename => "clientes.xlsx"
        end
      end 
    end
  end
  
  def create
    if Appuser.exists?(:email => params[:appuser][:email])
      @appuser = Appuser.find_by_email(params[:appuser][:email])
      @appuser.update(appuser_params)
    else  
    @appuser = Appuser.create(appuser_params)
    @appuser.car_id = @appuser.modelId
    @appuser.save
    end
    
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