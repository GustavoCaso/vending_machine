# frozen_string_literal: true

require_relative '../lib/coin_holder'

RSpec.describe CoinHolder do
  describe '#new' do
    context 'when no initial value is provided' do
      it 'creates a default amount of coins' do
        coin_holder = CoinHolder.new
        expect(coin_holder.coins).to all(be_a(Coin))
      end
    end

    context 'when initial value is provided' do
      it 'store the value for the coins' do
        coin_holder = CoinHolder.new(coins: [])
        expect(coin_holder.coins).to eq([])
      end
    end
  end

  describe '#add' do
    subject { described_class.new(coins: []) }

    context 'when value is a valid coin value' do
      it 'adds a new coin' do
        expect do
          subject.add(1)
        end.to change(subject.coins, :count).by(1)
      end
    end

    context 'when value is an invalid coin value' do
      it 'raises an exception' do
        expect { subject.add(578) }.to raise_error(CoinHolder::InvalidCoinValue)
      end
    end
  end

  describe '#total' do
    subject { described_class.new }

    it 'returns the total value' do
      expect(subject.total).to eq 388
    end
  end

  describe '#redeem' do
    let(:coin) { instance_double('Coin', value: 1) }
    subject { described_class.new(coins: [coin]) }

    it 'extract the coin' do
      expect(subject.redeem(1)).to eq coin
    end

    it 'returns nil if no coin is found' do
      expect(subject.redeem(2)).to eq nil
    end
  end
end
