Rails.application.routes.draw do
  post 'users/:user_id/tasks/update_task/:id', to: 'tasks#update_task', as: 'update_user_task'
  get 'users/login', to: 'users#login', as: 'login'
  post 'users/authenticate', to: 'users#auth', as:'auth'
  get 'users/logout', to: 'users#logout', as: 'logout'
  root 'users#index'
  get 'users/mail_auth', to:'users#mail_confirm'
  resources :users do
    resources :tasks
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
