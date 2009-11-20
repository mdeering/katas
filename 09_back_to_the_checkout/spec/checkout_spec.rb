require File.dirname(__FILE__) + '/spec_helper'

PRICING_RULES = {
  :prices    => {
    'A' => 50,
    'B' => 30,
    'C' => 20,
    'D' => 15
  },
  :discounts => {
    'A' => {
      :amount   => 20,
      :quantity => 3
    },
    'B' => {
      :amount   => 15,
      :quantity => 2
    }
  }
}.freeze

describe Checkout do

  def price_check(items, total)
    checkout = Checkout.new(PRICING_RULES)
    items.split(//).each do |item|
      checkout.scan(item)
    end
    checkout.total.should == total
  end

  {
    ''       => 0,
    'A'      => 50,
    'B'      => 30,
    'C'      => 20,
    'D'      => 15,
    'AB'     => 80,
    'BA'     => 80,
    'AAA'    => 130,
    'BB'     => 45,
    'ABBAA'  => 175,
    'DABABA' => 190
  }.each do |items, total|
    it "will have a total of #{total} if the items at the checkout are '#{items}" do
      price_check(items, total)
    end
  end

end
