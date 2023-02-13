require_relative '../../lib/discounts/bulk_purchase_discount'

describe BulkPurchaseDiscount do
  subject(:bulk_purchase_discount) { described_class.new(product_code: 'TSHIRT', min_products_count: 3, reduce_product_amount_by: 100) }

  describe '#apply' do
    it 'is expected to apply the discount on orders which contain more than the number of items' do
      expect(bulk_purchase_discount.apply(8500, { "TSHIRT" => 4 })).to eq 400
    end

    it 'is expected to apply no discount on orders which contain less than the number of items' do
      expect(bulk_purchase_discount.apply(4000, { "TSHIRT" => 2 })).to eq 0
    end
  end
end
