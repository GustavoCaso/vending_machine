class ProductCatalog
  ProductNotFound = Class.new(StandardError)

  DEFAULT_CATALOG = {
    coke: { price: 100, amount: 10 },
    sprite: { price: 100, amount: 10 },
    orange_juice: { price: 100, amount: 10 },
    lemon_juice: { price: 100, amount: 10 },
  }

  attr_reader :catalog

  def initialize(catalog: DEFAULT_CATALOG)
    @catalog = catalog
  end

  def product_list
    catalog.each_with_object('') do |(product_name, info), acc|
      acc << "#{product_name} => #{info[:price]}\n"
    end.strip
  end

  def add_product(product)
    catalog << product
  end

  def find_product(product)
    catalog.select { |key, info| key == product }
  end

  def get_product(product_name)
    if product = catalog[product_name]
      update_amount(product_name, product)
      product
    else
      raise ProductNotFound
    end
  end

  private

  def update_amount(product_name, product)
    new_amount = product[:amount] - 1
    if new_amount == 0
      @catalog.delete(product_name)
    else
      new_product_info = product.merge(amount: new_amount)
      @catalog = @catalog.merge(product_name => new_product_info)
    end
  end
end
