Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

resources :users, only: [:new, :create, :show, :index] do 
  resources :goals, only: :new 
end 

resource :session, only: [:new, :create, :destroy]

resources :goals, only: [:create, :destroy, :show]

end
