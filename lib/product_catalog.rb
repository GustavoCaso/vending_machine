require_relative 'product'

class ProductCatalog
  ProductNotFound = Class.new(StandardError)

  DEFAULT_CATALOG = [
    Product.new('Coke', 100, 10),
    Product.new('Sprite', 100, 10),
    Product.new('Orange Juice', 100, 10),
    Product.new('Lemon Juice', 100, 10)
  ].freeze

  attr_reader :catalog

  def initialize(catalog: DEFAULT_CATALOG)
    @catalog = catalog
  end

  def product_list
    catalog.each_with_object('') do |product, acc|
      acc << "#{product.name} => #{product.price}\n"
    end.strip
  end

  def add_product(name, value)
    if (product = find_product(name))
      product.increase_amount
      new_catalog = catalog[catalog.index(product)] = product
      self.class.new(catalog: new_catalog)
    else
      self.class.new(catalog: catalog << Product.new(name, value, 1))
    end
  end

  def get_product(product_name)
    product = find_product(product_name)
    raise ProductNotFound unless product
    product
  end

  def dispense(product)
    update_catalog(product)
    product
  end

  private

  def find_product(product_name)
    catalog.find { |product| product.name == product_name }
  end

  def update_catalog(product)
    product.decrease_amount
    if product.amount.zero?
      self.class.new(catalog: catalog.delete_at(catalog.index(product)))
    else
      new_catalog = catalog[catalog.index(product)] = product
      self.class.new(catalog: new_catalog)
    end
  end
end
