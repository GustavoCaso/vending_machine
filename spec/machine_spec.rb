RSpec.describe Machine do
  subject { described_class.new }

  describe '#new' do
    it 'has access to products' do
      expect(subject).to respond_to(:products)
    end

    it 'has access to coins' do
      expect(subject).to respond_to(:coins)
    end
  end

  describe '#insert_money' do
    it 'starts with 0' do
      expect(subject.total_amount).to eq 0
    end

    it 'increment the amount of money' do
      expect(subject.insert_money(10)).to eq 10
    end
  end

  describe '#order' do
    let(:products) { double('product_catalog') }
    let(:coins) { double('coins_holder') }
    subject { described_class.new(products: products, coins: coins) }
    context 'when there is enough amount to buy the product' do
      context 'when the amount is the same as the product price' do
        it 'returns the produc and 0 change' do
          expect(products).to receive(:find).and_return('COCA-COLA')
          expect(coins).to receive(:call).and_return(0)
          product, change = subject.order('COCA-COLA')
          expect(product).to eq('COCA-COLA')
          expect(change).to eq 0
        end
      end
    end
  end
end
