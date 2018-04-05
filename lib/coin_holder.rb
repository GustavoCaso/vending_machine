# frozen_string_literal: true
require_relative 'coin'

class CoinHolder
  InvalidCoinValue = Class.new(StandardError)

  DEFAULT_COINS = Coin::VALUES.map do |value|
    Coin.new(value)
  end

  attr_reader :coins

  def initialize(coins: DEFAULT_COINS)
    @coins = coins
  end

  def add(coin_value)
    coin = Coin.new(coin_value)
    coins << coin_value
  rescue Coin::InvalidCoin
    raise InvalidCoinValue
  end

  def total
    coins.inject(0) { |acc, coin| acc + coin.value }
  end
end