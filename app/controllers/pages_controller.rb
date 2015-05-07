class PagesController < ApplicationController
  
  def home
    redirect_to offers_path if logged_in?
  end
end