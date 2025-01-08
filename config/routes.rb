Rails.application.routes.draw do
  get "users/index"
  
  # Route cho đăng nhập và đăng ký
  resource :session, only: [:new, :create, :destroy]  # Dùng cho đăng nhập, tạo session, và logout
  resources :users, only: [:new, :create] 
  # Route cho người dùng (tạo, chỉnh sửa, xóa, v.v.)
  resources :users, except: [:new, :create]  # Để lại các route như index, edit, update, destroy, show

  # Định nghĩa các route cho mật khẩu
  resources :passwords, param: :token, only: [:new, :create, :edit, :update]

  # Định nghĩa các route cho sản phẩm
  resources :products do
    collection do
      get 'all_products', to: 'products#all_products'
    end
  
    resources :subscribers, only: [:create]
    resource :unsubscribe, only: [:show]
    resources :orders, only: [:show]
  end

  # Route cho trang chi tiết sản phẩm (chi tiết riêng cho từng sản phẩm)
  get 'products/details', to: 'products#details', as: 'products_details'

  # Kiểm tra trạng thái ứng dụng
  get "up" => "rails/health#show", as: :rails_health_check
  
  # Trang chủ
  root "products#index"
end
