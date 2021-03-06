Rails.application.routes.draw do
  
    # stats
    get 'stats', to: 'stats#index'

    # admin
    get 'admin/points'
    post 'admin/award_points'
    post 'admin/update_all_points'

    # homepage
    get 'homepage/index'

    # Root
    root to: 'root#root'

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
    get '/teams', to: 'root#root'

    # Team selection Ajax
    post '/team_selection', to: 'teams#team_selection'

    # Leagues
    get '/leagues/stage-3', to: 'leagues#stage_3'
    resources :leagues, only: [:index, :new, :create, :show]

    # League memberships
    resources :league_memberships, only: [:create, :destroy]

    # Account activations
    resources :account_activations, only: [:edit]

    resources :competitions, only: [:index, :show]

    get '/rules-and-guidance', to: 'static#rules_and_guidance'
    get '/blog', to: 'static#blog'
    get '/welcome', to: 'static#welcome'
    get '/payment', to: 'static#payment'
    get '/contact', to: 'static#contact'
    get '/transfers', to: 'static#transfers'

    match '*path' => 'application#error_404', via: :all
end
