class NotificationsController < ApplicationController
 
 before_action :require_logged__user
 
 def index
   
 end
 
 def resumen_notificacion
  
 end
 
 def require_logged__user
  if !logged_in?
   flash[:danger] = "Para realizar esa acción debes tener una sesión iniciada"
   redirect_to root_path
  end
 end
  
end
  