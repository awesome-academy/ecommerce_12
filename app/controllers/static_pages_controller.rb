class StaticPagesController < ApplicationController
  def home
    @products = Product.sorted.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def help; end

  def about; end

  def contact; end
end
