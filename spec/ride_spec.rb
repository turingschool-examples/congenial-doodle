# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe Ride do
  subject(:first_ride) do
    described_class.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
  end

  let(:second_ride) do
    described_class.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
  end
  let(:third_ride) do
    described_class.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
  end

  let(:first_visitor) { Visitor.new('Bruce', 54, '$10') }
  let(:second_visitor) { Visitor.new('Tucker', 36, '$5') }
  let(:third_visitor) { Visitor.new('Penny', 64, '$15') }

  describe '#initialize' do
    it { is_expected.to be_instance_of described_class }

    it 'has a name' do
      expect(first_ride.name).to eq('Carousel')
    end

    it 'has a minimum height' do
      expect(first_ride.min_height).to eq(24)
    end

    it 'has an admission fee' do
      expect(first_ride.admission_fee).to eq(1)
    end

    it 'has an excitement level' do
      expect(first_ride.excitement).to eq(:gentle)
    end

    it 'has no revenue' do
      expect(first_ride.total_revenue).to eq(0)
    end

    it 'has empty rider log' do
      expect(first_ride.rider_log).to eq({})
    end
  end

  describe '#board_rider' do
    context 'when rider is not eligible to ride' do
      it 'rejects rider who is not tall enough' do
        second_visitor.add_preference(:thrilling)

        expect(third_ride.board_rider(second_visitor)).to be_nil
      end

      it 'rejects rider who cannot afford ride' do
        first_visitor.add_preference(:gentle)
        first_visitor.spend_money(10)

        expect(second_ride.board_rider(first_visitor)).to be_nil
      end

      it 'rejects rider who does not have matching preference' do
        first_visitor.add_preference(:thrilling)

        expect(first_ride.board_rider(first_visitor)).to be_nil
      end
    end

    context 'when rider is eligible to ride' do
      it 'can board rider' do
        first_visitor.add_preference(:gentle)

        expect(first_ride.board_rider(first_visitor)).not_to be_nil
      end
    end
  end

  describe '#rider_log' do
    before do
      first_visitor.add_preference(:gentle)
      second_visitor.add_preference(:gentle)
      first_ride.board_rider(first_visitor)
      first_ride.board_rider(second_visitor)
      first_ride.board_rider(first_visitor)
    end

    it 'returns hash of riders with amount of times ridden' do
      expect(first_ride.rider_log).to eq({ first_visitor => 2, second_visitor => 1 })
    end
  end
end
