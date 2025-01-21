require './lib/visitor'
require 'rspec'

RSpec.describe Visitor do 
    before(:each) do 
        @visitor1 = Visitor.new('Bruce', 54, '$10')
        @visitor2 = Visitor.new('Tucker', 36, '$5')
        @visitor3 = Visitor.new('Penny', 64, '$15')
    end

    it 'exists' do 
        expect(@visitor1).to be_a(Visitor)
        expect(@visitor1.name).to eq('Bruce')
        expect(@visitor1.height).to eq(54)
        expect(@visitor1.spending_money).to eq('$10')
        expect(@visitor1.preference).to eq([])
    end

    it 'adds preferences' do 
        @visitor1.add_preference(:gentle)
        @visitor1.add_preference(:thrilling)

        expect(@visitor1.preference).to eq([:gentle, :thrilling])
    end

    it 'checks if visitor is tall enough' do 
        @visitor1.tall_enough?(54)
        @visitor2.tall_enough?(54)
        @visitor3.tall_enough?(54)
        @visitor1.tall_enough?(64)

        expect(@visitor1.tall_enough?(54)).to be(true)
        expect(@visitor2.tall_enough?(54)).to be(false)
        expect(@visitor3.tall_enough?(54)).to be(true)
        expect(@visitor1.tall_enough?(64)).to be(false)
    end
end
