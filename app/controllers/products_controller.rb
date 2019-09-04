class ProductsController < ApplicationController
  def index
    @products = Product.sorted.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t ".danger_flash"
    redirect_to root_url
  end
end
