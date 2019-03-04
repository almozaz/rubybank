Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'application/login'
  root "application#login"
  post 'application/authenticate'
  get "application/home"
  get 'application/logout'

  post 'transactions/make_deposit'
end
