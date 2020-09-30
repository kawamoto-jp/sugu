Rails.application.routes.draw do
  # get 'favorites/create'
  # get 'favorites/destroy'
  # get 'relationships/create'
  # get 'relationships/destroy'
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
    # resources :relationships, only: [:create, :destroy]
    # get :follows, on: :member # 追加
    # get :followers, on: :member
  end
  resources :users 
end
