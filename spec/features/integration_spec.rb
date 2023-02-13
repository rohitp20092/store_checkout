require_relative '../../lib/checkout'
require_relative '../../lib/product'
require_relative '../../lib/discounts/bulk_purchase_discount'
require_relative '../../lib/discounts/free_product_discount'

describe 'Integration Specs' do
  let(:products) do
    [
      Product.new(code: 'VOUCHER', name: 'Voucher', price: 500),
      Product.new(code: 'TSHIRT', name: 'T-Shirt', price: 2000),
      Product.new(code: 'MUG', name: 'Coffee Mug', price: 750)
    ]
  end

  let(:bulk_purchase_discount) { BulkPurchaseDiscount.new(product_code: 'TSHIRT', min_products_count: 3, reduce_product_amount_by: 100) }
  let(:free_product_discount) { FreeProductDiscount.new(product_code: 'VOUCHER', min_products_count: 2, product_price: 500, free_products: 1) }
  let(:promotional_rules) { [bulk_purchase_discount, free_product_discount] }
  subject(:checkout) { Checkout.new(promotional_rules, products: products) }

  it 'No discount to be applied for the order' do
    checkout.scan('VOUCHER')
    checkout.scan('TSHIRT')
    checkout.scan('MUG')

    expect(checkout.total).to eq '$32.50'
  end

  it 'A special discount of 1 free product for 2 VOCHER purchased is to be applied' do
    checkout.scan('VOUCHER')
    checkout.scan('VOUCHER')
    checkout.scan('TSHIRT')

    expect(checkout.total).to eq '$25.00'
  end

  it 'A bulk purchase dicount for TSHIRT is to be applied' do
    checkout.scan('TSHIRT')
    checkout.scan('TSHIRT')
    checkout.scan('TSHIRT')
    checkout.scan('VOUCHER')
    checkout.scan('TSHIRT')

    expect(checkout.total).to eq '$81.00'
  end

  it 'Multiple discounts should be applied together in the right order' do
    checkout.scan('VOUCHER')
    checkout.scan('TSHIRT')
    checkout.scan('VOUCHER')
    checkout.scan('VOUCHER')
    checkout.scan('MUG')
    checkout.scan('TSHIRT')
    checkout.scan('TSHIRT')

    expect(checkout.total).to eq '$74.50'
  end
end
