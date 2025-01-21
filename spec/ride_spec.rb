require './lib/visitor'
require './lib/ride'
require 'pry'

RSpec.describe Ride do
  before(:each) do
    @visitor1 = Visitor.new('Bruce', 54, '$10')
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor3 = Visitor.new('Penny', 64, '$15')
    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
  end

  describe '#initialize' do
    it 'exists' do
      expect(@ride1).to be_a Ride
      expect(@ride2).to be_a Ride
      expect(@ride3).to be_a Ride
    end

    it 'has a name' do
      expect(@ride1.name).to eq('Carousel')
      expect(@ride2.name).to eq('Ferris Wheel')
      expect(@ride3.name).to eq('Roller Coaster')

    end

    it 'has a minimum height' do
      expect(@ride1.min_height).to eq(24)
      expect(@ride2.min_height).to eq(36)
      expect(@ride3.min_height).to eq(54)

    end

    it 'has an admisson fee' do
      expect(@ride1.admission_fee).to eq(1)
      expect(@ride2.admission_fee).to eq(5)
      expect(@ride3.admission_fee).to eq(2)

    end

    it 'has an excitement' do
      expect(@ride1.excitement).to eq(:gentle)
      expect(@ride2.excitement).to eq(:gentle)
      expect(@ride3.excitement).to eq(:thrilling)

    end
  end

  describe '#total_revenue' do
    it 'defaults to 0' do
      expect(@ride1.total_revenue).to eq(0)
      expect(@ride2.total_revenue).to eq(0)
      expect(@ride3.total_revenue).to eq(0)

    end
  end

  describe '#board_rider' do
    it 'logs each time rider rides' do
      @visitor1.add_preference(:gentle)
      @visitor2.add_preference(:gentle)
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)
    
      expect(@ride1.rider_log).to eq({@visitor1 => 2, @visitor2 => 1})
    end

    it 'will not let a rider who does not prefer the rides excitement ride' do
      @visitor1.add_preference(:gentle)
      @visitor2.add_preference(:gentle)
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)
      @ride3.board_rider(@visitor1)
    
      expect(@ride1.rider_log).to eq({@visitor1 => 2, @visitor2 => 1})
    end

    it 'will not let a rider who is too short ride' do
      @visitor1.add_preference(:gentle)
      @visitor2.add_preference(:gentle)
      @visitor2.add_preference(:thrilling)
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)
      @ride3.board_rider(@visitor2)
    
      expect(@ride1.rider_log).to eq({@visitor1 => 2, @visitor2 => 1})
    end


    it "reduces visitors spending money each ride" do
      @visitor1.add_preference(:gentle)
      @visitor2.add_preference(:gentle)
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)

      expect(@visitor1.spending_money).to eq(8)
      expect(@visitor2.spending_money).to eq(4)
    end

    it 'collects admission fees for each ride' do
      @visitor1.add_preference(:gentle)
      @visitor2.add_preference(:gentle)
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)
    
      expect(@ride1.total_revenue).to eq(3)
    end    
  end
end