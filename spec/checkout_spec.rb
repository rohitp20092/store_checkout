require_relative '../lib/checkout'

describe Checkout do
  let(:cart_klass) { double :Cart_klass, new: cart }
  let(:cart) { double :Cart }
  let(:product) { double :Product, code: 'VOUCHER' }
  let(:products) { [product] }
  subject(:checkout) { described_class.new(products: products, cart_klass: cart_klass) }

  describe '#scan' do
    it 'is expected to raise an error if given a code that is not in products' do
      expect{ checkout.scan('MUG') }.to raise_error 'MUG is not a valid product code'
    end
  end

  describe '#total' do
    it 'is expected to return the cost of the cart calculated by CostEngine' do
      checkout.scan('VOUCHER')
      checkout.scan('VOUCHER')

      allow(cart).to receive(:total)
        .with({'VOUCHER' => 2}).and_return(1000)

      expect(checkout.total).to eq '$10.00'
    end
  end
end
