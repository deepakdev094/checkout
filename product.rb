class Product
  attr_accessor :item_code, :name, :price, :discount_rules

  def initialize(item_code, name, price, discount_rules = [])
    @item_code = item_code
    @name = name
    @price = price
    @discount_rules = discount_rules
  end
end
