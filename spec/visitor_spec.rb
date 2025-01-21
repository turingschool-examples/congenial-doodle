require './lib/visitor'

RSpec.describe Visitor do
  before(:each) do
    @visitor1 = Visitor.new('Bruce', 54, '$10')
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor3 = Visitor.new('Penny', 64, '$15')
  end

  it 'creates a visitor' do
    expect(@visitor1).to be_a(Visitor)
  end

  it 'returns a visitors name' do
    expect(@visitor1.name).to eq("Bruce")
  end

  it 'returns a visitors height' do
    expect(@visitor1.height).to eq(54)
  end

  it 'returns a visitors spending money' do
    expect(@visitor1.spending_money).to eq(10)
  end

  it 'returns an array of starting preferences for visitor' do
    expect(@visitor1.preferences).to eq([])
  end

  it 'can add preferences to visitors and list them in an array' do
    @visitor1.add_preference(:gentle)
    @visitor1.add_preference(:thrilling)

    expect(@visitor1.preferences).to eq([:gentle, :thrilling])
  end

  it 'returns true if the visitor meets height requirements' do
    expect(@visitor1.tall_enough?(54)).to eq(true)
    expect(@visitor3.tall_enough?(54)).to eq(true)
  end

  it 'returns false if the visitor does not meet height requirements' do
    expect(@visitor2.tall_enough?(54)).to eq(false)
    expect(@visitor1.tall_enough?(64)).to eq(false)
  end
end