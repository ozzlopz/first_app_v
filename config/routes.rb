Rails.application.routes.draw do
    
    root 'pages#home'
    
    get '/home', to: 'pages#home'

    resources :offers
    
    resources :users, except: [:new]
    get '/register', to: 'users#new'
    
    get '/login', to: "logins#new"
    post '/login', to: "logins#create"
    get '/logout', to: "logins#destroy"
    
    resources :cars 
end
