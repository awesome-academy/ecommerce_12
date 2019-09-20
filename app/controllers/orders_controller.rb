class OrdersController < ApplicationController
  before_action :check_login
  before_action :check_carts, only: [:new, :create]
  before_action :current_carts, only: :create
  before_action :load_orders, only: :index
  before_action :load_order, only: [:show, :destroy]

  def index; end

  def show; end

  def new
    @order = current_user.orders.build
  end

  def create
    @order = current_user.orders.new order_params
    if @order.valid?
      begin
        ActiveRecord::Base.transaction do
          @order.save
          add_order_items
          flash[:success] = t ".success_checkout"
          redirect_to root_path
          clear_carts
        end
      rescue StandardError
        flash[:danger] = t ".danger_checkout"
        redirect_to carts_path
      end
    else
      render :new
    end
  end

  def destroy
    if @order.pending?
      begin
        ActiveRecord::Base.transaction do
          @order.cancelled!
          restore_qty_product
          flash[:success] = t ".success_cancel"
        end
      rescue StandardError
        flash[:success] = t ".danger_destroy"
      end
    else
      flash[:danger] = t ".danger_cancel"
    end
    redirect_to order_path(params[:id])
  end

  private

  def load_orders
    @orders = current_user.orders.newest
    @pending_orders = @orders.pending.paginate page: params[:page],
      per_page: Settings.per_page_orders
    @shipped_orders = @orders.shipped.paginate page: params[:page],
      per_page: Settings.per_page_orders
    @cancelled_orders = @orders.cancelled.paginate page: params[:page],
      per_page: Settings.per_page_orders
  end

  def load_order
    @order = current_user.orders.find_by id: params[:id]
    return if @order
    flash[:danger] = t ".danger_order"
    redirect_to orders_path
  end

  def order_params
    params.require(:order).permit :customer_name, :address, :phone
  end

  def add_order_items
    @order.order_details.create! order_items
    sub_qty_product
  end

  def order_items
    @order_items = []
    @carts.each do |key, value|
      if price = Product.price_by_id(key.to_i)
        order_items = {price: price, quantily: value.to_i, product_id: key.to_i}
        @order_items << order_items
      end
    end
    @order_items
  end

  def sub_qty_product
    @carts.each do |key, value|
      if product = Product.find_by(id: key.to_i)
        new_qty = product.quantily.to_i - value.to_i
        product.update_attribute :quantily, new_qty
      end
    end
  end

  def restore_qty_product
    @order.order_details.each do |order_detail|
      if product = order_detail.product
        new_qty = product.quantily + order_detail.quantily
        product.update_attribute :quantily, new_qty
      end
    end
  end
end
