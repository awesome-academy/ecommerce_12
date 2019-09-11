class CategoriesController < ApplicationController
  def show
    @category = Category.find_by id: params[:id]
    if @category
      @products = @category.products.sorted.paginate page: params[:page],
        per_page: Settings.per_page
    else
      flash[:danger] = t ".danger_flash"
      redirect_to root_url
    end
  end
end
