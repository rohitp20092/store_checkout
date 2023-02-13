require_relative 'cart'

class Checkout
  def initialize(promotional_rules = nil, products: nil, cart_klass: Cart)
    @products = products
    @cart = cart_klass.new(promotional_rules, products: products)
    @order = Hash.new(0)
  end

  def scan(product_code)
    fail "#{product_code} is not a valid product code" unless product_in_products?(product_code)
    @order[product_code] += 1
  end

  def total
    '$%.2f' % order_cost
  end

  private

  attr_reader :products, :cart, :order

  def order_cost
    (cart.total(order) / 100.0).round(2)
  end

  def product_in_products?(product_code)
    products.map{ |product| product.code }
      .include?(product_code)
  end
end
