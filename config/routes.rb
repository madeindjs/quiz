Rails.application.routes.draw do
  resources :users
  resources :responses
  resources :questions
  get 'signup',to:'users#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
