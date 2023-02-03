Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :articles
  resources :users, only: [:show, :edit, :update]
  root "articles#index"
end
