Rails.application.routes.draw do
    root to: 'users#new'

    # Sign Up
    get  '/signup',     to: 'users#new'
    post   '/signup',   to: 'users#create'

    # Sessions
    get    '/login',    to: 'sessions#new'
    post   '/login',    to: 'sessions#create'
    delete '/logout',   to: 'sessions#destroy'
end
