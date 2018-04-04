RSpec.describe ProductCatalog do
  subject { described_class.new }

  describe '#new' do
    it 'has access to products' do
      expect(subject).to respond_to(:catalog)
    end
  end

  describe '#product_list' do
    it 'displays a list of products with prices' do
      expected_result = "coke => 100\nsprite => 100\norange_juice => 100\nlemon_juice => 100"
      expect(subject.product_list).to eq expected_result
    end
  end

  describe '#add_product' do
    subject { described_class.new(catalog: []) }

    it 'adds a new product to the catalog' do
      subject.add_product('hello')
      expect(subject.catalog).to include('hello')
    end
  end

  describe '#find_product' do
    it 'returns the product' do
      expect(subject.find_product(:coke)).to eq({ coke: { price: 100, amount: 10 } })
    end
  end
end
