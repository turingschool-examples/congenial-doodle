require 'simplecov'
SimpleCov.start

require './lib/ride'
require './lib/visitor'

describe Ride do
    before :each do
        @ride1 = Ride.new({
            name: 'Carousel',
            min_height: 24,
            admission_fee: 1,
            excitement: :gentle
        })
        @ride2 = Ride.new({
            name: 'Roller Coaster',
            min_height: 54,
            admission_fee: 2,
            excitement:
            :thrilling
        })

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
            expect(@ride1.min_height).to eq(24)
            expect(@ride1.admission_fee).to eq(1)
            expect(@ride1.excitement).to eq(:gentle)
            expect(@ride1.total_revenue).to eq(0)
        end
    end

    describe '#board_rider' do
        it 'can board riders' do
            @ride1.board_rider(@visitor1)
            @ride1.board_rider(@visitor2)
            @ride1.board_rider(@visitor1)

            expect(@ride1.rider_log).to eq({
                @visitor1 => 2,
                @visitor2 => 1
            })
            expect(@visitor1.spending_money).to eq(8)
            expect(@visitor2.spending_money).to eq(4)
            expect(@ride1.total_revenue).to eq(3)
        end

        it 'can not board visitors without matching preferences' do
            @ride2.board_rider(@visitor1)

            expect(@visitor1.spending_money).to eq(10)
        end

        it 'can not board visitors who are too short' do
            @ride2.board_rider(@visitor2)

            expect(@visitor2.spending_money).to eq(5)
        end

        it 'can not board visitors if they cant pay admission fee' do
            8.times { @ride2.board_rider(@visitor3) }

            expect(@visitor3.spending_money).to eq(1)
            expect(@ride2.rider_log).to eq({
                @visitor3 => 7
            })
        end
    end

    describe '#total_riders' do
        it 'can return how many times it has been ridden' do
            7.times { @ride1.board_rider(@visitor1) }
            @ride1.board_rider(@visitor2)

            expect(@ride1.total_riders).to eq(8)
        end
    end

    describe '#visitors' do
        it 'can return an array of all visitors' do
            @ride1.board_rider(@visitor1)
            @ride1.board_rider(@visitor1)
            @ride1.board_rider(@visitor2)

            expect(@ride1.visitors).to eq([@visitor1, @visitor2])
        end
    end
end