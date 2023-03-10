Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end
  resources :users, only: [:show, :edit, :update]
  resources :articles
  resources :articles do
    resources :comments, only: [:create, :destroy]
    resource :likes, only: [:create, :destroy]
  end
  root "articles#index"
end
