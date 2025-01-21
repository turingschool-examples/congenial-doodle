require './lib/visitor'
require './lib/ride'
require './lib/carnival'
require 'pry'

RSpec.describe Carnival do 
    before :each do 
        @carnival = Carnival.new(10)
        @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
        @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
        @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
        @ride4 = Ride.new({ name: 'Sidewinder', min_height: 54, admission_fee: 5, excitement: :thrilling })
        @visitor1 = Visitor.new('Bruce', 54, '$10')
        @visitor2 = Visitor.new('Tucker', 36, '$5')
        @visitor3 = Visitor.new('Penny', 64, '$15')
        @visitor4 = Visitor.new('Brooke', 62, '$20')
        @visitor1.add_preference(:gentle)
        @visitor2.add_preference(:gentle)
        @visitor2.add_preference(:thrilling)
        @visitor3.add_preference(:thrilling)
        @visitor4.add_preference(:thrilling)
        @visitor4.add_preference(:gentle)
        
    end

    it 'exists' do
        expect(@carnival).to be_a Carnival
        expect(@carnival.duration).to eq(10)
        expect(@carnival.rides).to eq([])
    end

    it "adds rides to the carnival" do
        @carnival.add_ride(@ride1)
        @carnival.add_ride(@ride2)
        @carnival.add_ride(@ride3)
        @carnival.add_ride(@ride4)


        expect(@carnival.rides).to eq([@ride1, @ride2, @ride3, @ride4])
    end

    it "finds the most popular ride" do 
        @carnival.add_ride(@ride1)
        @carnival.add_ride(@ride2)
        @carnival.add_ride(@ride3)
        @carnival.add_ride(@ride4)

        @ride1.board_rider(@visitor1) 
        @ride1.board_rider(@visitor2)
        @ride1.board_rider(@visitor1)
        @ride3.board_rider(@visitor1) 
        @ride3.board_rider(@visitor2) 
        @ride2.board_rider(@visitor3) 
        @ride2.board_rider(@visitor2)
        @ride2.board_rider(@visitor1)
        @ride2.board_rider(@visitor2)
        @ride1.board_rider(@visitor3)
        @ride1.board_rider(@visitor3) 
        @ride4.board_rider(@visitor3)
        @ride4.board_rider(@visitor3)
        @ride4.board_rider(@visitor2)
        @ride4.board_rider(@visitor1)
        @ride4.board_rider(@visitor4)

        expect(@carnival.most_popular_ride).to eq(@ride1)
    end

    it "returns the most profitable ride" do
        @carnival.add_ride(@ride1)
        @carnival.add_ride(@ride2)
        @carnival.add_ride(@ride3)
        @carnival.add_ride(@ride4)

        @ride1.board_rider(@visitor1) 
        @ride1.board_rider(@visitor2)
        @ride1.board_rider(@visitor1)
        @ride3.board_rider(@visitor1) 
        @ride3.board_rider(@visitor2) 
        @ride2.board_rider(@visitor3) 
        @ride2.board_rider(@visitor2)
        @ride2.board_rider(@visitor1)
        @ride2.board_rider(@visitor2)
        @ride1.board_rider(@visitor3)
        @ride1.board_rider(@visitor3) 
        @ride4.board_rider(@visitor3)
        @ride4.board_rider(@visitor3)
        @ride4.board_rider(@visitor2)
        @ride4.board_rider(@visitor1)
        @ride4.board_rider(@visitor4)

        expect(@carnival.most_profitable_ride).to eq(@ride4)
    end

    it "returns the total revenue for from all it's rides" do 
        @carnival.add_ride(@ride1)
        @carnival.add_ride(@ride2)
        @carnival.add_ride(@ride3)
        @carnival.add_ride(@ride4)

        @ride1.board_rider(@visitor1) 
        @ride1.board_rider(@visitor2)
        @ride1.board_rider(@visitor1)
        @ride3.board_rider(@visitor1) 
        @ride3.board_rider(@visitor2) 
        @ride2.board_rider(@visitor3) 
        @ride2.board_rider(@visitor2)
        @ride2.board_rider(@visitor1)
        @ride2.board_rider(@visitor2)
        @ride1.board_rider(@visitor3)
        @ride1.board_rider(@visitor3) 
        @ride4.board_rider(@visitor3)
        @ride4.board_rider(@visitor3)
        @ride4.board_rider(@visitor2)
        @ride4.board_rider(@visitor1)
        @ride4.board_rider(@visitor4)

        expect(@carnival.total_revenue).to eq(23)
    end
end