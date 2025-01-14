class UsersController < ApplicationController
  # before_action :authenticated?, only: [:edit, :update]
  before_action :authenticate_admin, only: [:index, :destroy]

  def index
    @users = User.where.not(email_address: "duy0031@gmail.com")  # Loại bỏ admin khỏi danh sách
  end
  def destroy
    @user = User.find(params[:id])

    # Kiểm tra nếu người dùng không phải là admin hoặc là người dùng hiện tại
    if @user == current_user || @user.email_address == "duy0031@gmail.com"
      redirect_to user_path, alert: "Không thể xóa tài khoản này."
    else
      @user.destroy
      redirect_to user_path, notice: "Tài khoản đã bị xóa."
    end
  end

  def edit
    @user = User.find(params[:id])  # Lấy người dùng dựa trên id trong params
    # Kiểm tra nếu người dùng có quyền chỉnh sửa tài khoản này
    if @user != current_user && current_user.email_address != "duy0031@gmail.com"
      redirect_to root_path, alert: "Bạn không có quyền chỉnh sửa tài khoản này."
    end
  end
  def new
    @user = User.new  # Khởi tạo đối tượng @user để sử dụng trong form
  end
  def show
    @user = User.find(params[:id])
  end
  def create
    @user = User.find_or_initialize_by(email_address: user_params[:email_address])
  
    if @user.new_record?
      if @user.update(user_params)  # Thử cập nhật nếu là bản ghi mới
        flash[:notice] = "Tài khoản đã được tạo thành công!!"
        redirect_to login_path
      else
        render :new
      end
    else
      flash[:alert] = "Email đã tồn tại."
      render :new
    end
  end
  
  

  def update
    @user = User.find(params[:id])
  
    # Kiểm tra trùng email
    if @user.email_address != params[:user][:email_address] && User.exists?(email_address: params[:user][:email_address])
      flash.now[:alert] = "Email này đã được đăng ký rồi."
      render :edit
      return  # Dừng xử lý nếu có lỗi
    end
  
    if @user.update(user_params)
      redirect_to users_path, notice: "Tài khoản đã được cập nhật."
    else
      render :edit
    end
  end

  

  private
  def authenticate_admin
    # Kiểm tra xem người dùng có phải admin không
    unless current_user&.email_address == "duy0031@gmail.com"
      redirect_to root_path, alert: "Bạn không có quyền truy cập vào trang này."
    end
  end

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end
