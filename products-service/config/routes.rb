Rails.application.routes.draw do
  resources :products, only: [:index, :show]
  get "/health", to: proc { [200, {}, ['OK']] }
end
