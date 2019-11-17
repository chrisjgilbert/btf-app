Rails.application.routes.draw do
    # homepage
    get 'homepage/index'

    # Root
    root to: 'sessions#new'

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

    # Team selection Ajax
    post '/team_selection', to: 'teams#team_selection'

    # Leagues
    resources :leagues, only: [:index, :new, :create, :show]

    # League memberships
    resources :league_memberships, only: [:create, :destroy]

    # Account activations
    resources :account_activations, only: [:edit]

    get '/rules-and-guidance', to: 'static#rules_and_guidance'
    get '/blog', to: 'static#blog'
end
