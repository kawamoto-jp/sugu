Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 

  # devise_scope :user do
  #   get "sign_in", :to => "users/sessions#new"
  #   get "sign_out", :to => "users/sessions#destroy" 
  # end

  root to: "user_infos#index"

  get 'user_infos/search'

  resources :rooms, only: [:index, :new, :create] do
    resources :messages, only: [:index, :create]
  end
 
  resources :user_infos do
    collection do
      get 'pre_page'
      get 'false'
    end
    resources :favorites, only: [:index, :create, :destroy]
  end
end
