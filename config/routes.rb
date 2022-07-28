Rails.application.routes.draw do
  devise_for :players
  resources :players, only: [:index, :show]
  resources :factories do
    get 'upgrade', to: 'factories#upgrade'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'players#index'
end
