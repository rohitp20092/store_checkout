require_relative '../lib/product'

describe Product do
  subject(:product) { described_class.new(code: 'VOUCHER', name: 'Voucher', price: 500) }

  describe '#price' do
    it 'is expected to return the price of the product' do
      expect(product.price).to eq 500
    end
  end

  describe '#code' do
    it 'is expected to return the code for the product' do
      expect(product.code).to eq 'VOUCHER'
    end
  end
end
