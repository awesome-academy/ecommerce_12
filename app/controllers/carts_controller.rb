class CartsController < ApplicationController
  before_action :current_carts, except: [:show, :new, :edit]
  before_action :load_product, only: [:create, :update]
  before_action :load_products, only: :index

  def index; end

  def create
    if check_quantily
      add_item @product, @quantily
    else
      flash[:danger] = t ".danger_quantily"
    end
    redirect_to category_product_path(category_id: @product.category_id,
      id: @product.id)
  end

  def update
    if @carts.key? params[:id]
      if check_quantily
        @carts[params[:id]] = @quantily
        session[:carts] = @carts
        flash[:success] = t ".success_update"
      else
        flash[:danger] = t ".danger_quantily"
      end
    else
      flash[:danger] = t ".danger_update"
    end
    redirect_to carts_path
  end

  def destroy
    if @carts.key? params[:id]
      @carts.delete params[:id]
      flash[:success] = t ".success_delete"
      session[:carts] = @carts
    else
      flash[:danger] = t ".danger_delete"
    end
    redirect_to carts_path
  end

  private

  def load_products
    @products = Product.by_ids @carts.keys
  end

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t ".danger_product"
    redirect_to carts_path
  end

  def check_quantily
    @quantily = params[:quantily].to_i
    @quantily <= @product.quantily && @quantily >= Settings.min_quantily
  end

  def add_item product, quantily
    if @carts.key? product.id.to_s
      flash[:info] = t ".info_product"
    else
      @carts[product.id.to_s] = quantily
      session[:cart] = @carts
      flash[:success] = t ".success_add"
    end
  end
end
