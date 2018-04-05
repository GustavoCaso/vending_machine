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
        expect {
          subject.add(1)
        }.to change(subject.coins, :count).by(1)
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
end
