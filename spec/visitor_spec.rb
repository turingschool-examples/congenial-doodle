require 'simplecov'
SimpleCov.start

require './lib/visitor'

describe Visitor do
    before :each do
        @visitor1 = Visitor.new("Bruce", 54, '$10')
        @visitor2 = Visitor.new('Tucker', 36, '$5')
        @visitor3 = Visitor.new('Penny', 64, '$15')
    end

    describe '#initialize' do
        it 'exists' do
            expect(@visitor1).to be_a Visitor
            expect(@visitor1.name).to eq("Bruce")
            expect(@visitor1.height).to eq(54)
            expect(@visitor1.spending_money).to eq(10)
            expect(@visitor1.preferences).to eq([])
            expect(@visitor1.money_spent).to eq(0)
        end
    end

    describe '#preferences' do
        it 'can add and list out preferences' do
            @visitor1.add_preference(:gentele)
            @visitor1.add_preference(:thrilling)

            expect(@visitor1.preferences).to eq([:gentele, :thrilling])
        end
    end

    describe '#tall_enough?' do
        it 'can tell if a visitor is above a certain height' do
            expect(@visitor1.tall_enough?(54)).to eq(true)
            expect(@visitor2.tall_enough?(54)).to eq(false)
            expect(@visitor3.tall_enough?(54)).to eq(true)
            expect(@visitor1.tall_enough?(64)).to eq(false)
        end
    end

    describe '#pay_admission' do
        it 'can pay admission fees' do
            expect(@visitor1.pay_admission(10)).to eq(true)
            expect(@visitor1.spending_money).to eq(0)
            expect(@visitor1.money_spent).to eq(10)
        end

        it 'can not pay more than it has' do
            expect(@visitor1.pay_admission(20)).to eq(false)
            expect(@visitor1.spending_money).to eq(10)
            expect(@visitor1.money_spent).to eq(0)
        end
    end

    describe '#has_preference?' do
        it 'can determine if it has a givin preference' do
            @visitor1.add_preference(:gentle)
            expect(@visitor1.has_preference?(:gentle)).to eq(true)
        end

        it 'can determine if it does nto have a givin preference' do
            expect(@visitor1.has_preference?(:gentle)).to eq(false)
        end
    end
end