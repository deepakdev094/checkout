class DiscountRule
  attr_accessor :type, :quantity, :discount_price

  def initialize(type, quantity, discount_price)
    @type = type
    @quantity = quantity
    @discount_price = discount_price
  end
end
