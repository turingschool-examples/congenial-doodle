require './lib/ride'
require './lib/visitor'
require './lib/carnival'
require 'rspec'
require 'pry'

describe Carnival do
  before :each do
    @carnival = Carnival.new(14)
    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
    @carnival.add_ride(@ride1)
    @carnival.add_ride(@ride2)
    @carnival.add_ride(@ride3)
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
      expect(@carnival).to be_a(Carnival)
    end
  end

  describe 'add_ride' do
    it 'can add a ride to rides array' do
      expect(@carnival.rides).to eq([@ride1, @ride2, @ride3])
    end
  end

  describe 'most_popular_ride' do
    it 'can return ride ridden the most' do
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor3)
      @ride2.board_rider(@visitor3)
      expect(@carnival.most_popular_ride).to eq(@ride1)
    end
  end

  describe 'most_profitable_ride' do
    it 'can return most profitable ride' do
      @ride1.board_rider(@visitor1)
      @ride2.board_rider(@visitor2)
      @ride3.board_rider(@visitor3)
      expect(@carnival.most_profitable_ride).to eq(@ride2)
      @ride3.board_rider(@visitor3)
      @ride3.board_rider(@visitor3)
      expect(@carnival.most_profitable_ride).to eq(@ride3)
      @ride2.board_rider(@visitor1)
      expect(@carnival.most_profitable_ride).to eq(@ride2)
    end
  end

  describe '#total_revenue' do
    it 'can return total revenue of carnival' do
      @ride1.board_rider(@visitor1)
      @ride2.board_rider(@visitor2)
      @ride3.board_rider(@visitor3)
      expect(@carnival.total_revenue).to eq(8)
      @ride2.board_rider(@visitor1)
      expect(@carnival.total_revenue).to eq(13)
    end
  end

  # describe '#summary' do
  #   it 'can return hash summary of carnival' do
  #     @ride1.board_rider(@visitor1)
  #     @ride2.board_rider(@visitor2)
  #     @ride3.board_rider(@visitor3)
  #     expect(@carnival.summary).to eq({
  #       'Visitor count' => @carnival.visitor_count,
  #       'Revenue earned' => @carnival.total_revenue,
  #       'List of visitors' => @carnival.list_of_visitors
  #     })
  #   end
  # end

  # describe '#favorite ride' do
  #   it 'can return the ride the visitor has ridden the most' do
  #     @ride1.board_rider(@visitor1)
  #     @ride1.board_rider(@visitor1)
  #     @ride2.board_rider(@visitor1)
  #     expect(@carnival.favorite_ride(@visitor1)).to eq(@ride1)
  #   end
  # end
end