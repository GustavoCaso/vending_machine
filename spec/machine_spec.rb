RSpec.describe Machine do
  subject { described_class.new }

  describe '#new' do
    it 'has access to product_catalog' do
      expect(subject).to respond_to(:product_catalog)
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
        expect do
          subject.insert_money(2)
        end.to change(subject.total_amount.coins, :count).by(1)
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
        expect do
          subject.fill_change(2)
        end.to change(subject.change.coins, :count).by(1)
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
    context 'when product is not available' do
      it 'returns a message' do
        result = subject.order('Panini')
        expect(result).to eq 'Product not available'
      end
    end

    context 'when money inserted is the same as the product value' do
      let(:product) { instance_double('Product', name: 'Coke', price: 1, amount: 1) }
      let(:product_catalog) { ProductCatalog.new(catalog: [product]) }

      subject { described_class.new(product_catalog: product_catalog) }

      before do
        subject.insert_money(1)
        expect(product_catalog).to receive(:dispense).with(product).and_return(product)
      end

      it 'returns the product' do
        expect(subject.order('Coke')).to eq([product])
      end

      it 'resets the money inserted' do
        subject.order('Coke')
        expect(subject.total_inserted).to eq(0)
      end

      it 'moves the money inserted to the change' do
        expect {
          subject.order('Coke')
        }.to change(subject.change.coins, :count).by(1)
      end
    end

    context 'when money inserted is higher than product value' do
      let(:product) { instance_double('Product', name: 'Coke', price: 1, amount: 1) }
      let(:coin) { instance_double('Coin', value: 1) }
      let(:product_catalog) { ProductCatalog.new(catalog: [product]) }
      let(:change) { CoinHolder.new(coins: [coin]) }

      subject { described_class.new(product_catalog: product_catalog, change: change) }

      before do
        subject.insert_money(1)
        subject.insert_money(1)
        expect(product_catalog).to receive(:dispense).with(product).and_return(product)
      end

      it 'returns the product and change' do
        expect(subject.order('Coke')).to eq([product, coin])
      end

      it 'resets the money inserted' do
        subject.order('Coke')
        expect(subject.total_inserted).to eq(0)
      end

      it 'moves the money inserted to the change' do
        subject.order('Coke')
        expect(subject.change.coins.count).to eq(2)
      end
    end

    context 'when money inserted is lower than product value' do
      let(:product) { instance_double('Product', name: 'Coke', price: 2, amount: 1) }
      let(:product_catalog) { ProductCatalog.new(catalog: [product]) }

      subject { described_class.new(product_catalog: product_catalog) }

      before do
        subject.insert_money(1)
      end

      it 'returns a message' do
        expect(subject.order('Coke')).to eq('Not enough money to buy the product, you are missing 1 coin')
      end
    end

    context 'when there is not enough change to finish the transaction' do
      let(:product) { instance_double('Product', name: 'Coke', price: 1, amount: 1) }
      let(:product_catalog) { ProductCatalog.new(catalog: [product]) }

      subject { described_class.new(product_catalog: product_catalog, change: CoinHolder.new(coins: [])) }

      before do
        subject.insert_money(1)
        subject.insert_money(1)
      end

      it 'do not dispense the product' do
        expect(product_catalog).to_not receive(:dispense)
        subject.order('Coke')
      end

      it 'returns a message' do
        expect(subject.order('Coke')).to eq('Please contact the administrator there is not enough change for the transaction')
      end
    end
  end

  # describe '#order' do
  #   let(:product_catalog) { double('product_catalog') }
  #   let(:coins) { double('coins_holder') }
  #   subject { described_class.new(product_catalog: product_catalog, change: coins) }
  #   context 'when there is enough amount to buy the product' do
  #     context 'when the amount is the same as the product price' do
  #       it 'returns the produc and 0 change' do
  #         expect(products).to receive(:find).and_return('COCA-COLA')
  #         expect(coins).to receive(:call).and_return(0)
  #         product, change = subject.order('COCA-COLA')
  #         expect(product).to eq('COCA-COLA')
  #         expect(change).to eq 0
  #       end
  #     end
  #   end
  # end
end
