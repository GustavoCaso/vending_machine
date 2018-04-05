require_relative '../lib/coin'

RSpec.describe Coin do
  subject { described_class.new(value) }

  describe '#new' do
    context 'when value is one of the accepted' do
      let(:value) { 200 }

      it 'returns a Coin' do
        expect(subject).to be_a Coin
      end
    end

    context 'when value is not one of the accepted' do
      let(:value) { 789 }

      it 'raises an exception' do
        expect { subject }.to raise_error(Coin::InvalidCoin)
      end
    end
  end

  describe '#value' do
    let(:value) { 200 }
    it 'returns the value' do
      expect(subject.value).to eq(value)
    end
  end
end
