require './lib/visitor'
require './lib/ride'
require './lib/carnival'
require 'pry'

RSpec.describe Carnival do
    before(:each) do
        @visitor1 = Visitor.new('Bruce', 54, '$10')
        @visitor2 = Visitor.new('Tucker', 36, '$5')
        @visitor3 = Visitor.new('Penny', 64, '$15')
        @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
        @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
        @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
        @carnival1 = Carnival.new(14)
    end

    describe '#initialize' do

        it '#duration' do
            expect(@carnival1).to be_an_instance_of(Carnival)
            expect(@carnival1.duration).to eq(14)
        end

        it '#rides' do
            expect(@carnival1.rides).to eq([])
        end

        it '#visitors' do
            expect(@carnival1.visitors).to eq([])
        end
    end

    describe 'methods' do

        it '#add_ride' do
            @carnival1.add_ride(@ride1)
            @carnival1.add_ride(@ride2)
            @carnival1.add_ride(@ride3)
            expect(@carnival1.rides).to eq([@ride1, @ride2, @ride3])
        end

        it '#most_popular_ride' do
            @carnival1.add_ride(@ride1)
            @carnival1.add_ride(@ride2)
            @carnival1.add_ride(@ride3)
            @visitor1.add_preference(:gentle)
            @ride1.board_rider(@visitor1)
            @ride2.board_rider(@visitor1)
            @ride1.board_rider(@visitor1)
            expect(@carnival1.most_popular_ride).to eq(@ride1)
            @visitor3.add_preference(:thrilling)
            @ride3.board_rider(@visitor3)
            @ride3.board_rider(@visitor3)
            @ride3.board_rider(@visitor3)
            expect(@carnival1.most_popular_ride).to eq(@ride3)
        end

        it '#most_profitable_ride' do
            @carnival1.add_ride(@ride1)
            @carnival1.add_ride(@ride2)
            @carnival1.add_ride(@ride3)
            @visitor1.add_preference(:gentle)
            @ride1.board_rider(@visitor1)
            @ride2.board_rider(@visitor1)
            @ride1.board_rider(@visitor1)
            expect(@carnival1.most_profitable_ride).to eq(@ride2)
            @visitor3.add_preference(:thrilling)
            @ride3.board_rider(@visitor3)
            @ride3.board_rider(@visitor3)
            @ride3.board_rider(@visitor3)
            expect(@carnival1.most_profitable_ride).to eq(@ride3)
        end

        it '#total_revenue' do
            @carnival1.add_ride(@ride1)
            @carnival1.add_ride(@ride2)
            @carnival1.add_ride(@ride3)
            @visitor1.add_preference(:gentle)
            @ride1.board_rider(@visitor1)
            @ride2.board_rider(@visitor1)
            @ride1.board_rider(@visitor1)
            @visitor3.add_preference(:thrilling)
            @ride3.board_rider(@visitor3)
            @ride3.board_rider(@visitor3)
            @ride3.board_rider(@visitor3)
            expect(@carnival1.total_revenue).to eq(13)
        end

        it '#add_visitor' do #helper method
            @carnival1.add_visitor(@visitor1)
            @carnival1.add_visitor(@visitor2)
            @carnival1.add_visitor(@visitor3)
            expect(@carnival1.visitors).to eq([@visitor1, @visitor2, @visitor3])
        end

        # xit '#summary' do
        #     @carnival1.add_visitor(@visitor1)
        #     @carnival1.add_visitor(@visitor2)
        #     @carnival1.add_visitor(@visitor3)
        #     expect(Carnival.summary).to be_a(Hash)
        # end
    end
end
