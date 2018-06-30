Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "auth/registrations",
  }
  
  get  "/sign-up", to: "auth/auth#send_secret_code_form", as: :send_secret_code_form
  post "/sign-up", to: "auth/auth#send_secret_code"

  resources :secret_codes, only: [:index, :create]

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

end
