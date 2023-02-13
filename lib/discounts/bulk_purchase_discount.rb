class BulkPurchaseDiscount
  def initialize(product_code:, min_products_count:, reduce_product_amount_by:)
    @product_code = product_code
    @min_products_count = min_products_count
    @reduce_product_amount_by = reduce_product_amount_by
  end

  def apply(current_total, order)
    should_discount_be_applied?(order) ? apply_discount(order) : 0
  end

  private

  attr_reader :product_code, :min_products_count, :reduce_product_amount_by

  def should_discount_be_applied?(order)
    order[product_code] >= min_products_count
  end

  def apply_discount(order)
    order[product_code] * reduce_product_amount_by
  end
end
