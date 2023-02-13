require_relative '../../lib/discounts/free_product_discount'

describe FreeProductDiscount do
  subject(:free_product_discount) { described_class.new(product_code: 'VOUCHER', min_products_count: 2, product_price: 500, free_products: 1) }

  describe '#apply' do
    it 'is expected to apply the free product discount' do
      expect(free_product_discount.apply(1500, {})).to eq 500
    end

    it 'is expected to apply no discount' do
      expect(free_product_discount.apply(500, {})).to eq 0
    end
  end
end
