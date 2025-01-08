class ProductsController < ApplicationController
 
  # allow_unauthenticated_access only: %i[ index show ]
 
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  # before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
  def index
    @products = Product.all
     
  end
  def all_products
    @products = Product.all 
    
  end

  def show
    
  end
  
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: "Sản phẩm đã được tạo thành công."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    
  end

  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    @product.destroy
    redirect_to products_path
  end

  private
  def set_product
    if params[:id].present? && params[:id] != "new" && params[:id] != "all_products"
      @product = Product.find(params[:id])
    end
  end
    def product_params
      params.expect(product: [ :name, :description, :featured_image, :inventory_count ])
    end
end
