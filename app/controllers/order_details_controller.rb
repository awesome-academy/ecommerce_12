class OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find_by id: params[:id]
    if @order_detail
      update_qty
      redirect_to @order_detail.order
    else
      flash[:danger] = t ".danger_detail"
      redirect_to orders_path
    end
  end

  def destroy
    order_detail = OrderDetail.find_by id: params[:id]
    if order_detail
      order_detail.delete
      flash[:success] = t ".success_destroy"
      redirect_to order_detail.order
    else
      flash[:danger] = t ".danger_detail"
      redirect_to orders_path
    end
  end

  private

  def check_qty max
    quantily = params[:quantily].to_i
    quantily <= max && quantily >= Settings.min_quantily
  end

  def update_qty
    max = @order_detail.product.quantily + @order_detail.quantily
    if check_qty(max)
      begin
          ActiveRecord::Base.transaction do
            update_qty_product
            @order_detail.update_attribute :quantily, params[:quantily].to_i
            flash[:success] = t ".success_update"
          end
        rescue StandardError
          flash[:danger] = t ".danger_update"
        end
    else
      flash[:danger] = t ".danger_qty", max: max,
        min: Settings.min_quantily
    end
  end

  def update_qty_product
    return unless product = Product.find_by(id: @order_detail.product_id)
    new_qty = (product.quantily + @order_detail.quantily) -
              params[:quantily].to_i
    product.update_attribute :quantily, new_qty
  end
end
