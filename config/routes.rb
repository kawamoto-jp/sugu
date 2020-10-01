Rails.application.routes.draw do
  devise_for :users

  root to: "user_infos#index"

  get 'user_infos/search'

  resources :rooms
  resources :user_infos do
    collection do
      get 'pre_page'
      get 'false'
    end
    resources :favorites, only: [:index, :create, :destroy]
  end
end
