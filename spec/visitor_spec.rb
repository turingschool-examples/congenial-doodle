# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe Visitor do
  subject(:first_visitor) { described_class.new('Bruce', 54, '$10') }

  describe '#initialize' do
    it { is_expected.to be_instance_of described_class }

    it 'has a name' do
      expect(first_visitor.name).to eq('Bruce')
    end

    it 'has a height' do
      expect(first_visitor.height).to eq(54)
    end

    it 'has spending money' do
      expect(first_visitor.spending_money).to eq(10)
    end

    it 'has no preferences' do
      expect(first_visitor.preferences).to eq([])
    end
  end

  describe '#add_preference' do
    it 'can add preferences' do
      first_visitor.add_preference(:gentle)
      first_visitor.add_preference(:thrilling)

      expect(first_visitor.preferences).to eq(%i[gentle thrilling])
    end
  end

  describe '#tall_enough?' do
    context 'when the visitor is not tall enough' do
      subject(:tall_enough?) { first_visitor.tall_enough?(64) }

      it { is_expected.to be false }
    end

    context 'when the visitor is tall enough' do
      subject(:tall_enough?) { first_visitor.tall_enough?(53) }

      it { is_expected.to be true }
    end
  end

  describe '#spend_money' do
    it 'can spend money' do
      expect(first_visitor.spend_money(2)).to eq(8)
    end
  end
end
