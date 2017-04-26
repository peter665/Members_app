Rails.application.routes.draw do
  get 'posts/new'

  post 'posts/create'

  get 'posts/index'

  root 'static_pages#home'

  resources :users
  
  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'

end
