# frozen_string_literal: true

require_relative 'product_catalog'
require_relative 'coin_holder'

class Machine
  extend Forwardable

  def_delegator :@product_catalog, :product_list

  attr_reader :product_catalog, :change, :total_amount

  def initialize(product_catalog: ProductCatalog.new, change: CoinHolder.new)
    @product_catalog = product_catalog
    @change = change
    @total_amount = CoinHolder.new(coins: [])
  end

  def insert_money(coin)
    add_coin(total_amount, coin)
  end

  def total_inserted
    total_amount.total
  end

  def fill_change(coin)
    add_coin(change, coin)
  end

  def add_product(name: , price: )
    product_catalog.add_product(name, price)
  end

  def order(product_name)
    product = product_catalog.get_product(product_name)
    process_order(product)
  rescue ProductCatalog::ProductNotFound
    'Product not available'
  end

  private

  def process_order(product)
    product_price = product.price

    if product_price < total_inserted
      handle_product_and_change(product, product_price)
    elsif product_price == total_inserted
      [dispense(product)]
    else
      "Not enough money to buy the product, you are missing #{product_price - total_inserted} coin"
    end
  end

  def handle_product_and_change(product, product_price)
    if (change_to_return = get_change(product_price))
      [dispense(product), change_to_return]
    else
      'Please contact the administrator there is not enough change for the transaction'
    end
  end

  def dispense(product)
    move_money_to_change
    reset_total_amount
    product_catalog.dispense(product)
  end

  def move_money_to_change
    @change = change.combine(total_amount)
  end

  def reset_total_amount
    @total_amount = CoinHolder.new(coins: [])
  end

  def get_change(product_price)
    change.redeem(total_inserted - product_price)
  end

  def add_coin(coin_holder, coin)
    coin_holder.add(coin)
  rescue CoinHolder::InvalidCoinValue
    'Not an accepted value'
  end
end
