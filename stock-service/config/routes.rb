require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  get '/stock_summary', to: 'stock_summary#index'
  post "/refresh_stock_summary", to: "stock_summary#refresh"
end
