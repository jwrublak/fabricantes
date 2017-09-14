Rails.application.routes.draw do
  resources :fabricantes do
  	resources :produtos
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
