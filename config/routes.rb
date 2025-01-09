Rails.application.routes.draw do
  get 'login', to: 'sessions#new', as: 'login'

  # Route cho người dùng và phiên đăng nhập
  resources :users, except: [:index]
  resources :products do
    collection do
      get :all_products
    end
    resources :subscribers, only: [:create]
    resource :unsubscribe, only: [:show]
  end
  resources :users, only: [:new, :create, :edit, :update, :destroy, :show, :index]
  resource :session, only: [:new, :create, :destroy]
  resources :passwords, param: :token, only: [:new, :create, :edit, :update]

  # Route kiểm tra trạng thái ứng dụng
  get "up" => "rails/health#show", as: :rails_health_check

  # Trang chủ
  root "products#index"
end
