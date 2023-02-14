require_relative 'discount'
require_relative 'product'
require_relative 'checkout'

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
co.scan('VOUCHER')
price = co.total
puts "Total price: #{price}"

co = Checkout.new(products)
co.scan('VOUCHER')
co.scan('TSHIRT')
co.scan('VOUCHER')
co.scan('VOUCHER')
co.scan('MUG')
co.scan('TSHIRT')
co.scan('VOUCHER')
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
