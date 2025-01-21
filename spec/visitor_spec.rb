require './lib/visitor.rb'
require './lib/ride.rb'     #Not ideal, but still stays within Law of Demeter (nearest neighbor only) and avoids external setting of instance vars

RSpec.describe Visitor do
  before(:each) do
    @visitor1 = Visitor.new('Bruce', 54, '$10')
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor3 = Visitor.new('Penny', 64, '$15')
    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
  end

  it "exists" do
    expect(@visitor1).to be_a(Visitor)
  end

  it "initializes correctly" do
    expect(@visitor1.name).to eq("Bruce")
    expect(@visitor1.height).to eq(54)
    expect(@visitor1.spending_money).to eq(10)
    expect(@visitor1.preferences).to eq([])
  end

  it "can add and store preferences" do
    @visitor1.add_preference(:gentle)
    @visitor1.add_preference(:thrilling)

    expect(@visitor1.preferences).to eq([:gentle, :thrilling])

    expect(@visitor2.preferences).to eq([])

    @visitor2.add_preference(:agile)

    expect(@visitor2.preferences).to eq([:agile])
  end

  it "can verify if visitor is tall enough for a given ride" do
    expect(@visitor1.tall_enough?(54)).to eq(true)
    expect(@visitor2.tall_enough?(54)).to eq(false)
    expect(@visitor3.tall_enough?(54)).to eq(true)
    expect(@visitor1.tall_enough?(64)).to eq(false)
  end

  it "can pay admission fees for rides" do
    @visitor1.pay_fee(@ride1, 6)
    expect(@visitor1.spending_money).to eq(4)
    #Throw error if insufficient funds (though Ride#board_ride() should catch this)
    expect(@visitor1.pay_fee(@ride1, 6)).to eq(false)
    expect(@visitor1.spending_money).to eq(4)
  end

  it "correctly tracks rides ridden, and determines favorite ride and money spent" do
    @visitor1.pay_fee(@ride1, 3)
    @visitor1.pay_fee(@ride1, 3)
    @visitor1.pay_fee(@ride2, 2)

    expect(@visitor1.rides_ridden).to eq({@ride1 => 2, @ride2 => 1})
    expect(@visitor1.favorite_ride()).to eq(@ride1)
    expect(@visitor1.money_spent()).to eq(8)
  end

end
