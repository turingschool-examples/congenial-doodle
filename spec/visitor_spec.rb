require './lib/visitor'

RSpec.describe Visitor do
  before(:each) do
    @visitor1 = Visitor.new('Bruce', 54, '$10')
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor3 = Visitor.new('Penny', 64, '$15')
  end

  describe '#initialize' do
    it 'exists' do
      expect(@visitor1).to be_a Visitor
      expect(@visitor2).to be_a Visitor
      expect(@visitor3).to be_a Visitor
    end

    it 'has a name' do
      expect(@visitor1.name).to eq('Bruce')
      expect(@visitor2.name).to eq('Tucker')
      expect(@visitor3.name).to eq('Penny')

    end

    it 'has a height' do
      expect(@visitor1.height).to eq(54)
      expect(@visitor2.height).to eq(36)
      expect(@visitor3.height).to eq(64)

    end

    it 'has spending money' do
      expect(@visitor1.spending_money).to eq(10)
      expect(@visitor2.spending_money).to eq(5)
      expect(@visitor3.spending_money).to eq(15)

    end
  end

  describe '#preferences' do
    it 'defaults an empty array for preferences' do
      expect(@visitor1.preferences).to eq([])
      expect(@visitor2.preferences).to eq([])
      expect(@visitor3.preferences).to eq([])
    end

    it 'can have preferences added using add_preference method' do
      @visitor1.add_preference(:gentle)
      @visitor1.add_preference(:thrilling)

      expect(@visitor1.preferences).to eq([:gentle, :thrilling])
    end
  end

  describe '#tall_enough?' do
    it 'returns true if visitor height is greater than or equal to argument given' do
      expect(@visitor1.tall_enough?(54)).to eq(true)
      expect(@visitor3.tall_enough?(54)).to eq(true)
    end

    it 'returns false if visitor height is less than argument given' do
      expect(@visitor2.tall_enough?(54)).to eq(false)
      expect(@visitor1.tall_enough?(64)).to eq(false)
    end
  end
end







