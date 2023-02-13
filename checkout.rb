require 'byebug'

class Product
  attr_accessor :item_code, :name, :price, :discount_rules

  def initialize(item_code, name, price, discount_rules = [])
    @item_code = item_code
    @name = name
    @price = price
    @discount_rules = discount_rules
  end
end

class DiscountRule
  attr_accessor :type, :quantity, :discount_price

  def initialize(type, quantity, discount_price)
    @type = type
    @quantity = quantity
    @discount_price = discount_price
  end
end

class Checkout
  attr_accessor :products ,:items

  def initialize(products)
    @products = products
    @items = []
  end

  def scan(item_code)
    product = products.find { |p| p.item_code == item_code }
    return unless product

    @items << product
  end

  def total
    total_price = 0
    @items.group_by(&:item_code).each do |item_code, items|
      product = products.find { |p| p.item_code == item_code }
      discount_rule = product.discount_rules.find { |r| items.count >= r.quantity }
      if discount_rule
        if discount_rule.type == "x for y" && items.count >= discount_rule.quantity
          total_price += (items.count * product.price - (((items.count / discount_rule.quantity) * discount_rule.discount_price) * product.price))
        elsif discount_rule.type == "bulk" && items.count >= discount_rule.quantity
          total_price += (items.count * discount_rule.discount_price)
        else
          total_price += items.count * product.price
        end
      else
        total_price += items.count * product.price
      end
    end
    total_price
  end
end

#Here we create the rules
rule1 = DiscountRule.new(type = "x for y",x = 2, y = 1)
rule2 = DiscountRule.new(type = "bulk", quantity = 3, new_price = 19.00)

#Create products with some set of rules which was decleared above
product1 = Product.new('VOUCHER', 'Voucher', 5.00, [rule1])
product2 = Product.new('TSHIRT', 'T-Shirt', 20.00, [rule2])
product3 = Product.new('MUG', 'Coffee Mug', 7.50)

products = [ product1, product2 , product3 ]

co = Checkout.new(products)
co.scan('VOUCHER')
co.scan('TSHIRT')
co.scan('MUG')
price = co.total
puts "Total price: #{price}"

co = Checkout.new(products)
co.scan('VOUCHER')
co.scan('TSHIRT')
co.scan('VOUCHER')
co.scan('VOUCHER')
co.scan('MUG')
co.scan('TSHIRT')
co.scan('TSHIRT')
price = co.total
puts "Total price: #{price}"

co = Checkout.new(products)
co.scan('TSHIRT')
co.scan('TSHIRT')
co.scan('TSHIRT')
co.scan('VOUCHER')
co.scan('TSHIRT')
price = co.total
puts "Total price: #{price}"