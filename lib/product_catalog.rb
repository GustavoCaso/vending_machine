require_relative 'product'

class ProductCatalog
  ProductNotFound = Class.new(StandardError)

  DEFAULT_CATALOG = [
    Product.new('Coke', 100, 10),
    Product.new('Sprite', 100, 10),
    Product.new('Orange Juice', 100, 10),
    Product.new('Lemon Juice', 100, 10)
  ]

  attr_reader :catalog

  def initialize(catalog: DEFAULT_CATALOG)
    @catalog = catalog
  end

  def product_list
    catalog.each_with_object('') do |product, acc|
      acc << "#{product.name} => #{product.price}\n"
    end.strip
  end

  def add_product(product)
    catalog << product
  end

  def find_product(product_name)
    catalog.find { |product| product.name == product_name }
  end

  def get_product(product_name)
    if product = find_product(product_name)
      update_amount(product)
      product
    else
      raise ProductNotFound
    end
  end

  private

  def update_amount(product)
    product.decrease_amount
    if product.amount == 0
      catalog.delete_at(catalog.index(product))
    else
      catalog[catalog.index(product)] = product
    end
  end
end
