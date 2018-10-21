Rails.application.routes.draw do
  post 'users/:user_id/tasks/update_task/:id', to: 'tasks#update_task', as: 'update_user_task'
  root 'users#index'
  resources :users do
    resources :tasks
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
