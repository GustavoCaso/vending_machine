# frozen_string_literal: true

require_relative '../lib/product'

RSpec.describe Product do
  subject { described_class.new('Coke', 100, 10) }

  it { expect(subject.name).to eq 'Coke' }
  it { expect(subject.price).to eq 100 }
  it { expect(subject.amount).to eq 10 }

  describe '#increase_amount' do
    it 'increases the amount' do
      subject.increase_amount
      expect(subject.amount).to eq 11
    end
  end

  describe '#decrease_amount' do
    it 'decreases the amount' do
      subject.increase_amount
      expect(subject.amount).to eq 11
    end
  end
end
