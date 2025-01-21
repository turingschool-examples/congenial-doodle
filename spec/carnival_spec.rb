require 'rspec'
require 'pry'
require './lib/visitor'
require './lib/ride'
require './lib/carnival'

RSpec.describe Carnival do
  before (:each) do
    @carnival1 = Carnival.new("Toad Circus", 14)

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
      expect(@carnival1).to be_a Carnival
      expect(@carnival1.name).to eq ("Toad Circus")
      expect(@carnival1.duration).to eq 14
    end
  end

  describe 'rides at the carnival' do
    it 'can add rides' do
      expect(@carnival1.rides).to eq []

      @carnival1.add_ride(@ride1)
      @carnival1.add_ride(@ride2)
      @carnival1.add_ride(@ride3)

      expect(@carnival1.rides).to eq [@ride1, @ride2, @ride3]
    end

    it 'can tell the most popular ride' do
      @carnival1.add_ride(@ride1)
      @carnival1.add_ride(@ride2)
      @carnival1.add_ride(@ride3)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)
      @ride3.board_rider(@visitor3)
      @ride3.board_rider(@visitor3)

      expect(@carnival1.most_popular_ride).to eq @ride1
    end

    it 'can tell the most profitable ride' do
      @carnival1.add_ride(@ride1)
      @carnival1.add_ride(@ride2)
      @carnival1.add_ride(@ride3)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)
      @ride3.board_rider(@visitor3)
      @ride3.board_rider(@visitor3)

      expect(@carnival1.most_profitable_ride).to eq @ride3
    end
  end

  describe '#total_revenue' do
    it 'can add up total revenue from all rides' do
      @carnival1.add_ride(@ride1)
      @carnival1.add_ride(@ride2)
      @carnival1.add_ride(@ride3)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)
      @ride3.board_rider(@visitor3)
      @ride3.board_rider(@visitor3)

      expect(@carnival1.total_revenue).to eq 7
    end
  end

  describe 'iteration 4' do
    it '#add visitor helper method' do
      @carnival1.add_visitor(@visitor1)
      @carnival1.add_visitor(@visitor2)
      @carnival1.add_visitor(@visitor3)

      expect(@carnival1.visitors).to eq [@visitor1, @visitor2, @visitor3]
    end

    it '#summary' do
      @carnival1.add_ride(@ride1)
      @carnival1.add_ride(@ride2)
      @carnival1.add_ride(@ride3)

      @carnival1.add_visitor(@visitor1)
      @carnival1.add_visitor(@visitor2)
      @carnival1.add_visitor(@visitor3)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)
      @ride3.board_rider(@visitor3)
      @ride3.board_rider(@visitor3)

      expect(@carnival1.summary).to eq ({
                                          visitor_count: 3,
                                          revenue_earned: 7,
                                          visitors: [@visitor1, @visitor2, @visitor3],
                                          rides: [@ride1, @ride2, @ride3]
                                        })
    end
  end
end

# visitors: [@visitor1, @visitor2, @visitor3],
#                                           rides: [{ ride: @ride1,
#                                                     riders: [@visitor1, @visitor2],
#                                                     total_revenue: 3},
#                                                   { ride: @ride3,
#                                                     riders: [@visitor3],
#                                                     total_revenue: 4}]