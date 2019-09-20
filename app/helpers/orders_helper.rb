module OrdersHelper
  def total_price_order order_details
    order_details.reduce(0) do |total, product|
      total + product.price * product.quantily
    end
  end
end
