Rails.application.routes.draw do
  get '/stock_summary', to: 'stock_summary#index'
end
