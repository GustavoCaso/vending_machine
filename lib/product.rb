# frozen_string_literal: true

class Product
  attr_reader :name, :price, :amount

  def initialize(name, price, amount)
    @name, @price, @amount = name, price, amount
  end

  def decrease_amount
    @amount = amount - 1
  end

  def increase_amount
    @amount = amount + 1
  end
end
