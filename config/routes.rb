Rails.application.routes.draw do
  namespace :v1, :defaults => {format: :json} do

    get 'orders/fetchorder/:id' => 'orders#fetch_order'
    get 'orders/invoice_data' => 'orders#invoice_data'
    resources :orders

  end
end
