Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }
  resources :users, only: [:show, :edit, :update]
  resources :movies, only: [:index, :show, :create, :edit, :update, :destroy] do
    resources :comments, only: [:create, :destroy]
    resource :likes, only: [:create, :destroy]
  end
  root :to => 'homes#top'
  get 'homes/about'
  get 'search' => 'movies#search'
end
