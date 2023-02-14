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
          total_price += (items.count * product.price - ((items.count / discount_rule.quantity) * discount_rule.discount_price) * product.price)
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
