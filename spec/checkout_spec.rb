require './checkout'
RSpec.describe Checkout do
  let(:discount_rule1) { DiscountRule.new(type = "x for y", x = 2, y = 1) }
  let(:discount_rule2) {DiscountRule.new(type = "bulk" , 3 , 7)}
  let(:product1) { Product.new('VOUCHER', 'Voucher', 5.00, [discount_rule1]) }
  let(:product2) { Product.new('TSHIRT', 'T-Shirt', 20.00) }
  let(:product3) { Product.new('MUG', 'Coffee Mug', 7.50, [discount_rule2]) }
  let(:products) { [product1, product2, product3] }
  let(:checkout) { Checkout.new(products) }

  it 'can scan a product' do
    checkout.scan('VOUCHER')
    expect(checkout.items.count).to eq 1
  end

  it 'calculates the total price correctly' do
    checkout.scan('VOUCHER')
    checkout.scan('MUG')
    checkout.scan('MUG')
    expect(checkout.total).to eq 20.0

    checkout = Checkout.new(products)
    checkout.scan('VOUCHER')
    checkout.scan('TSHIRT')
    checkout.scan('VOUCHER')
    checkout.scan('VOUCHER')
    checkout.scan('MUG')
    checkout.scan('TSHIRT')
    checkout.scan('VOUCHER')
    expect(checkout.total).to eq 57.5

    checkout = Checkout.new(products)
    checkout.scan('TSHIRT')
    checkout.scan('TSHIRT')
    checkout.scan('TSHIRT')
    checkout.scan('VOUCHER')
    checkout.scan('TSHIRT')
    expect(checkout.total).to eq 85.00

    checkout = Checkout.new(products)
    checkout.scan('MUG')
    checkout.scan('MUG')
    checkout.scan('MUG')
    checkout.scan('VOUCHER')
    checkout.scan('MUG')
    expect(checkout.total).to eq 33
  end
end