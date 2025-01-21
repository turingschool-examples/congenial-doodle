require './lib/ride'
require './lib/visitor'
require 'rspec'
require 'pry'

describe Ride do
  before :each do
    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
    @visitor1 = Visitor.new('Bruce', 54, '$10')
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor3 = Visitor.new('Penny', 64, '$15')
    @visitor1.add_preference(:gentle)
    @visitor2.add_preference(:gentle)
    @visitor2.add_preference(:thrilling)
    @visitor3.add_preference(:thrilling)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@ride1).to be_a(Ride)
      expect(@ride1.name).to eq("Carousel")
    end
  end

  describe '#board_rider' do
    it 'can board a rider' do
      expect(@ride1.rider_log).to eq({})
      @ride1.board_rider(@visitor1)
      expect(@ride1.rider_log.keys.count).to eq(1)
    end

    it 'can update spending money and total revenue' do
      @ride1.board_rider(@visitor1)
      expect(@visitor1.spending_money).to eq(9)
      expect(@ride1.total_revenue).to eq(1)
    end

    it 'will not board rider if requirements are not met' do
      @ride3.board_rider(@visitor2)
      expect(@visitor2.spending_money).to eq(5)
      expect(@ride3.total_revenue).to eq(0)
    end
  end
end