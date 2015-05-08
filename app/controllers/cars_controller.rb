class CarsController < ApplicationController
   before_action :set_car, only: [:edit,:update,:show] 
   before_action :require_logged__user
   before_action :require_user
   before_action :admin_user, only: [:edit,:update]
   before_action :developer_user, only: [:new,:create,:destroy]
   
  def index
    @cars = Car.paginate(page: params[:page], per_page: 4)
  end
  
  def show
    @offers = @car.offers.paginate(page: params[:page], per_page: 4)
  end
  
  def new
    @car = Car.new
  end
  
  def create
    @car = Car.new(car_params)
    
    if @car.save
      flash[:success] = "Se ha creado la categoría exitosamente"
      redirect_to cars_path
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    if @car.update(car_params)
      flash[:success] = "La categoría ha sido editada exitosamente"
      redirect_to cars_path
    else
      render :edit
    end
  end
  
  def destroy
    Car.find(params[:id]).destroy
    flash[:success] = "Categoría borrada exitosamente"
    redirect_to cars_path
  end
  
  
  private
    def car_params
      params.require(:car).permit(:name)
    end
    
    def set_car
      @car = Car.find(params[:id])
    end
    
    def admin_user
      redirect_to cars_path unless current_user.admin?
    end
    
    def developer_user
      redirect_to cars_path unless current_user.developer?
    end
    
    def require_logged__user
      if !logged_in?
        flash[:danger] = "Para realizar esa acción debes tener una sesión iniciada"
       redirect_to root_path
      end
    end
    
end
