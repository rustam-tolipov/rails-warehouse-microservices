Rails.application.routes.draw do
  resources :transactions, only: [:create, :index]
  get "/health", to: proc { [200, {}, ['OK']] }
end
