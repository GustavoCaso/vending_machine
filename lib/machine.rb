# frozen_string_literal: true
require_relative 'product_catalog'
require_relative 'coin_holder'

class Machine
  attr_reader :products, :change, :total_amount

  def initialize(products: nil, change: CoinHolder.new)
    @products = products
    @change = change
    @total_amount = CoinHolder.new(coins: [])
  end

  def insert_money(coin)
    total_amount.add(coin)
  rescue CoinHolder::InvalidCoinValue
    'Not an accepted value'
  end

  def total_inserted
    total_amount.total
  end

  def fill_change(coin)
    change.add(coin)
  rescue CoinHolder::InvalidCoinValue
    'Not an accepted value'
  end

  def order(product)
    [products.find(product), return_change]
  end

  private

  def return_change
    change.call
  end
end
