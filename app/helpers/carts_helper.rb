module CartsHelper
  def amount_product quantity, price
    quantity * price
  end

  def total_price carts, products
    products.reduce(0) do |total, product|
      total + product.price * carts[product.id.to_s]
    end
  end

  def price quantily, price
    number_to_currency (quantily.to_i * price), locale: :en
  end

  def count_carts
    count = 0
    if current_carts.present?
      current_carts.each do |_key, value|
        count += value.to_i
      end
    end
    count
  end

  def current_carts
    session[:carts] ||= {}
    @carts = session[:carts]
  end
end
