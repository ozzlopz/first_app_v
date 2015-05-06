class OffersController < ApplicationController
  
  before_action :set_offer, only: [:edit,:update,:show] 
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @offers = Offer.paginate(page: params[:page], per_page: 4)
  end
  
  def show
   
  end
  
  def new
    @offer = Offer.new
  end
  
  def create
    @offer = Offer.new(recipe_params)
    @offer.user = current_user
    
    if @offer.save
      flash[:success] = "La oferta ha sido creada exitosamente"
      redirect_to offers_path
    else
      render :new
    end
  end
  
  def edit

  end
  
  def update
    if @offer.update(recipe_params)
      flash[:success] = "La oferta ha sido editada exitosamente"
      redirect_to offer_path(@offer)
    else
      render :edit
    end
    
  end
  
  def destroy
    Offer.find(params[:id]).destroy
    flash[:success] = "Oferta borrada exitosamente"
    redirect_to recipes_path
  end
  
  private
  
    def recipe_params
      params.require(:offer).permit(:name,:summary,:description,:picture)
      #,,style_ids:[],ingredient_ids:[])
    end
    
    def set_offer
      @offer = Offer.find(params[:id])
    end
    
    def require_same_user
      if current_user != @offer.user and !current_user.admin?
        flash[:danger] = "Solamente puedes editar ofertas publicadas por otros usuarios si tu cuenta es de administrador"
        redirect_to offers_path
      end
    end
    
    def admin_user
      redirect_to offers_path unless current_user.admin?
    end
end