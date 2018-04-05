RSpec.describe Machine do
  subject { described_class.new }

  describe '#new' do
    it 'has access to products' do
      expect(subject).to respond_to(:products)
    end

    it 'has access to change' do
      expect(subject).to respond_to(:change)
    end
  end

  describe '#total_inserted' do
    it 'starts with 0' do
      expect(subject.total_inserted).to eq 0
    end
  end

  describe '#insert_money' do
    context 'when value is valid' do
      it 'adds the value' do
        expect{
          subject.insert_money(2)
        }.to change(subject.total_amount.coins, :count).by(1)
      end
    end

    context 'when value is invalid' do
      it 'returns a message' do
        result = subject.insert_money(90)
        expect(result).to eq 'Not an accepted value'
      end
    end
  end

  describe '#fill_change' do
    context 'when value is valid' do
      it 'adds the value' do
        expect{
          subject.fill_change(2)
        }.to change(subject.change.coins, :count).by(1)
      end
    end

    context 'when value is invalid' do
      it 'returns a message' do
        result = subject.fill_change(90)
        expect(result).to eq 'Not an accepted value'
      end
    end
  end

  describe '#order' do
    let(:products) { double('product_catalog') }
    let(:coins) { double('coins_holder') }
    subject { described_class.new(products: products, change: coins) }
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
