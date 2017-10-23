Rails.application.routes.draw do
  resources :achievements, only: [:index, :new, :create, :show]
  root 'welcome#index'
end
