require_relative '../lib/cart'

describe Cart do
  let(:product_1) { double :Product, code: "VOUCHER", price: 500 }
  let(:product_2) { double :Product, code: "MUG", price: 2000 }
  let(:products) { [product_1, product_2] }
  let(:free_product_discount) { double :FreeProductDiscount, apply: 0 }
  let(:promotional_rules) { [free_product_discount] }

  subject(:cost_engine) { described_class.new(promotional_rules, products: products) }

  describe '#total' do
    it 'is expected to calculate basket without any bonuses' do
      order = { "VOUCHER" => 1 }
      expect(cost_engine.total(order)).to eq 500
    end

    it 'is expected to be able to apply a given discount' do
      allow(free_product_discount).to receive(:apply).and_return 500
      order = { "VOUCHER" => 3 }
      expect(cost_engine.total(order)).to eq 1000
    end
  end
end
