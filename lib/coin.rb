require 'set'

class Coin
  InvalidCoin = Class.new(StandardError)

  VALUES = Set[1,2,5,10,20,50,100,200]

  attr_reader :value

  def initialize(value)
    raise InvalidCoin unless VALUES.include?(value)
    @value = value
  end
end
