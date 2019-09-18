module CartsHelper
  def amount_product quantity, price
    quantity * price
  end

  def total_price
    products = Product.by_ids current_carts.keys
    products.reduce(0) do |total, product|
      total + product.price * @carts[product.id.to_s].to_i
    end
  end

  def total_price_product id
    if product = Product.find_by(id: id)
      number_to_currency (current_carts[id.to_s].to_i * product.price),
        locale: :en
    else
      flash[:danger] = I18n.t ".carts.danger_product"
      redirect_to carts_path
    end
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
    clean_carts
    @carts = session[:carts]
  end

  def check_carts
    return if current_carts.present?
    flash[:danger] = I18n.t ".carts.carts_empty"
    redirect_to carts_path
  end

  def clear_carts
    session.delete :carts
  end

  def clean_carts
    return unless session[:carts].present?
    session[:carts].each do |key, _value|
      session[:carts].delete key unless Product.find_by id: key
    end
  end
end
