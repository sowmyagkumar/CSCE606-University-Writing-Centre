Rails.application.routes.draw do
  get 'tasks/new'
  get 'tasks/show'
  get 'tasks/edit'
  root 'users#index'
  resources :users do
    resources :tasks
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
