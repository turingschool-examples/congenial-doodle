require './lib/carnival'
require './lib/visitor'
require './lib/ride'
require 'pry'

RSpec.describe Carnival do
  before(:each) do
    @visitor1 = Visitor.new('Bruce', 54, '$10')
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor3 = Visitor.new('Penny', 64, '$15')
    @visitor1.add_preference(:gentle)
    @visitor2.add_preference(:gentle)
    @visitor3.add_preference(:thrilling)
    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
    @carnival1 = Carnival.new('Fun', '14 days')

  end

  describe '#initialize' do
    it 'exists' do
      expect(@carnival1).to be_a Carnival
    end

    it 'has a name' do
      expect(@carnival1.name).to eq('Fun')
    end

    it 'has a duration' do
      expect(@carnival1.duration).to eq(14)
    end
  end

  describe '#rides' do
    it 'defaults an empty array' do
      expect(@carnival1.rides).to eq([])
    end

    it 'adds rides to array via add_ride(ride)' do
      @carnival1.add_ride(@ride1)
      @carnival1.add_ride(@ride2)
      @carnival1.add_ride(@ride3)
  

      expect(@carnival1.rides).to eq([@ride1, @ride2, @ride3])
    end
  end

  describe 'most_popular_ride' do
    it 'returns ride object ridden the highest number of times by visitors' do
      @carnival1.add_ride(@ride1)
      @carnival1.add_ride(@ride2)
      @carnival1.add_ride(@ride3)
  

      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor2)
      @ride2.board_rider(@visitor1)
      @ride2.board_rider(@visitor1)
      @ride3.board_rider(@visitor3)

      expect(@carnival1.most_popular_ride).to eq(@ride1)
    end
  end

  describe 'most_popular_ride' do
    it 'returns ride object ridden the highest number of times by visitors' do
      @carnival1.add_ride(@ride1)
      @carnival1.add_ride(@ride2)
      @carnival1.add_ride(@ride3)
  

      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor2)
      @ride2.board_rider(@visitor1)
      @ride2.board_rider(@visitor1)
      @ride3.board_rider(@visitor3)

      expect(@carnival1.most_profitable_ride).to eq(@ride2)
    end
  end

  describe '#total_revenue' do
    it 'returns ride object ridden the highest number of times by visitors' do
      @carnival1.add_ride(@ride1)
      @carnival1.add_ride(@ride2)
      @carnival1.add_ride(@ride3)
  

      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor2)
      @ride2.board_rider(@visitor1)
      @ride2.board_rider(@visitor1)
      @ride3.board_rider(@visitor3)

      expect(@carnival1.total_revenue).to eq(15)
    end
  end
end

