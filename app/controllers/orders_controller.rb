class OrdersController < ApplicationController
  def show
    @product = Product.find(params[:product_id])
    @order = Order.find(params[:id]) # Tìm một đơn hàng cụ thể
  end
end
