# frozen_string_literal: true
require_relative 'product_catalog'

class Machine
  attr_reader :products, :coins, :total_amount

  def initialize(products: nil, coins: nil)
    @products = products
    @coins = coins
    @total_amount = 0
  end

  def insert_money(amount)
    @total_amount += amount
  end

  def order(product)
    [products.find(product), change]
  end

  private

  def change
    coins.call
  end
end
