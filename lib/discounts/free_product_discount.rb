class FreeProductDiscount
  def initialize(product_code:, min_products_count:, product_price:, free_products:)
    @product_code = product_code
    @min_products_count = min_products_count
    @free_products = free_products
    @product_price = product_price
  end

  def apply(current_total, order)
    should_discount_be_applied?(order) ? apply_discount(order) : 0
  end

  private

  attr_reader :product_code, :min_products_count, :free_products, :product_price

  def should_discount_be_applied?(order)
    (order[product_code] / min_products_count).positive?
  end

  def apply_discount(order)
    ((order[product_code] / min_products_count) * free_products) * product_price
  end
end
