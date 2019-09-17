class ProductsController < ApplicationController
  def index
    @products = Product.sorted.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
    @category = Category.find_by id: params[:category_id]
    if @category
      @product = @category.products.find_by id: params[:id]
      return if @product
      flash[:danger] = t ".danger_product"
    else
      flash[:danger] = t ".danger_category"
    end
    redirect_to root_url
  end
end
