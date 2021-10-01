# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :oauth, only: [:index, :show, :create]
      resources :webhook, only: [:index, :show, :create]
      resources :projects, only: [:index, :show, :create]
      resources :settings, only: [:index, :show, :create]
      resources :issues, only: [ :create]
    end
  end
end
