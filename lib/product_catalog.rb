class ProductCatalog

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
end
