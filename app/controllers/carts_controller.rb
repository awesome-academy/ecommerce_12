class CartsController < ApplicationController
  before_action :current_carts, only: [:index, :create]

  def index
    @products = Product.by_ids @carts.keys
    @total = total_price @carts, @products
  end

  def create
    @product = Product.find_by id: params[:product_id]
    if @product
      quantily = params[:quantily].to_i
      check_quantily @product, quantily
    else
      flash[:danger] = t ".danger_product"
      redirect_to root_path
    end
  end

  private

  def check_quantily product, quantily
    max = product.quantily
    if quantily <= max && quantily >= Settings.min_quantily
      add_item product, quantily
    else
      flash[:danger] = t ".danger_quantily"
    end
    redirect_to category_product_path(category_id: @product.category_id,
      id: @product.id)
  end

  def add_item product, quantily
    if @carts.include? product.id.to_s
      flash[:info] = t ".info_product"
    else
      @carts[product.id.to_s] = quantily
      session[:cart] = @carts
      flash[:success] = t ".success_add"
    end
  end
end
