class Checkout

  attr :total

  def initialize(pricing_rules)
    @prices = pricing_rules[:prices]
    @discounts = pricing_rules[:discounts]
    @total = 0
    @item_counts = Hash.new(0)
  end

  def scan(item)
    @item_counts[item] += 1
    @total += @prices[item] if @prices.has_key?(item)
    @total -= @discounts[item][:amount] if @discounts.has_key?(item) && @item_counts[item] % @discounts[item][:quantity] == 0
  end

end
