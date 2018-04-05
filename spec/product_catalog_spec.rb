RSpec.describe ProductCatalog do
  subject { described_class.new }

  describe '#new' do
    it 'has access to products' do
      expect(subject).to respond_to(:catalog)
    end
  end

  describe '#product_list' do
    it 'displays a list of products with prices' do
      expected_result = "Coke => 100\nSprite => 100\nOrange Juice => 100\nLemon Juice => 100"
      expect(subject.product_list).to eq expected_result
    end
  end

  describe '#add_products' do
    subject { described_class.new(catalog: []) }

    it 'adds a new product to the catalog' do
      subject.add_products('hello')
      expect(subject.catalog).to include('hello')
    end
  end

  describe '#get_product' do
    it 'returns the product' do
      expect(subject.get_product('Coke')).to be_a(Product)
    end

    it 'raises an exception if no product is found' do
      expect{ subject.get_product('fake') }.to raise_error(ProductCatalog::ProductNotFound)
    end
  end

  describe '#dispense' do
    let(:coke) { Product.new("Coke", 100, 10) }
    let(:sprite) { Product.new("Sprite", 100, 1) }
    let(:catalog) { [ coke , sprite] }

    subject { described_class.new(catalog: catalog) }

    it 'extract the product from the catalog and update amount' do
      result = subject.dispense(coke)
      product = subject.get_product('Coke')

      expect(product.amount).to eq 9
      expect(result).to eq(product)
    end

    it 'removes the product from the catalog if no more left' do
      subject.dispense(sprite)
      expect(subject.catalog).to_not include(sprite)
    end
  end
end
