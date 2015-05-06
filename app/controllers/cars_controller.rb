class CarsController < ApplicationController
   before_action :require_user
   
  def show
    @car = Car.find(params[:id])
    @offers = @car.offers.paginate(page: params[:page], per_page: 4)
  end
  
  def new
    @car = Car.new
  end
  
  def create
    @car = Car.new(car_params)
    
    if @car.save
      flash[:success] = "Se ha creado la categoría exitosamente"
      redirect_to offers_path
    else
      render 'new'
    end
  end
  
  private
    def car_params
      params.require(:car).permit(:name)
    end
end
