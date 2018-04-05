# frozen_string_literal: true

require_relative 'product_catalog'
require_relative 'coin_holder'

class Machine
  attr_reader :product_catalog, :change, :total_amount

  def initialize(product_catalog: ProductCatalog.new, change: CoinHolder.new)
    @product_catalog = product_catalog
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

  def add_products(products)
    product_catlog.store(products)
  end

  def display_products
    product_catalog.product_list
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
    @total_amount = CoinHolder.new(coins: [])
    product_catalog.dispense(product)
  end

  def get_change(product_price)
    change.redeem(total_inserted - product_price)
  end
end
