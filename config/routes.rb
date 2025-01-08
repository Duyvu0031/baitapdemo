Rails.application.routes.draw do
  # Route cho người dùng và phiên đăng nhập
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :edit, :update, :destroy, :show]
  resources :passwords, param: :token, only: [:new, :create, :edit, :update]
  resources :users, only: [:index, :show, :edit, :update, :destroy, :new]  
  # Route cho sản phẩm
  resources :products do
    collection do
      get :all_products  # Đảm bảo route này hoạt động cho action all_products
    end
    resources :subscribers, only: [:create]
    resource :unsubscribe, only: [:show]
  end

  # Route thêm chi tiết sản phẩm (nếu cần thiết)
  get 'products/:id/details', to: 'products#details', as: 'products_details'

  # Route kiểm tra trạng thái ứng dụng
  get "up" => "rails/health#show", as: :rails_health_check

  # Trang chủ
  root "products#index"
end
