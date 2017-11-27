Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  root to: "fabricantes#index"

  resources :fabricantes do
  	resources :produtos
  end

  resources :events, only: [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
