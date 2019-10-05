Rails.application.routes.draw do
    root to: 'users#new'

    # Sign Up
    get  '/signup',     to: 'users#new'
    post   '/signup',   to: 'users#create'

    # Sessions
    get    '/login',    to: 'sessions#new'
    post   '/login',    to: 'sessions#create'
    delete '/logout',   to: 'sessions#destroy'

    # Dashboard
    get '/dashboard',   to: 'dashboards#show'

    # Passowrd Resets
    resources :password_resets, only: [:new, :create, :edit, :update]

    # Teams
    resources :teams, only: [:new, :create, :show, :edit, :update]

    # Leagues
    resources :leagues, only: [:new, :create, :show]
end
