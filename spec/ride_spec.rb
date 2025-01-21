require "./spec/spec_helper.rb"


RSpec.describe Visitor do
  before(:each) do
    @visitor1 = Visitor.new("Bruce", 54, "$10")
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor3 = Visitor.new('Penny', 64, '$15')

    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
    
    @visitor1.add_preference(:gentle)
    @visitor2.add_preference(:gentle)
    @visitor2.add_preference(:thrilling)
    @visitor3.add_preference(:thrilling)
  end

  describe "initialize" do
    it "exists" do
      expect(@ride1).to be_an_instance_of(Ride)
    end
    it "has a name" do
      expect(@ride1.name).to eq('Carousel')
    end
    it "has min height" do
      expect(@ride1.min_height).to eq(24)
    end
    it "has admission fee" do
      expect(@ride1.admission_fee).to eq(1)
    end
    it "has the excitement level" do
      expect(@ride1.excitement).to eq(:gentle)
    end
    it "has a place to store total revenue" do
      expect(@ride1.total_revenue).to eq(0)
    end
    it 'has a rider log initialized as a hash' do
      expect(@ride1.rider_log).to eq({})
    end
  end

  describe "methods" do
    it "can add to the rider log" do
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)

      expected_log = {
        @visitor1 => 2,
        @visitor2 => 1
      }

      expect(@ride1.rider_log).to eq(expected_log)
    end
    it "takes away money for ride" do
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)

      expect(@visitor1.spending_money).to eq(8)
      expect(@visitor2.spending_money).to eq(4)
    end
    it "tracks the total revenue" do
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      
      expect(@ride1.total_revenue).to eq(3)
    end
    it 'can reject visitors' do
      @ride3.board_rider(@visitor1)
      @ride3.board_rider(@visitor2)
      @ride3.board_rider(@visitor3)
      
    expected_log = {
      @visitor3 => 1
    }

    expect(@ride3.rider_log).to eq(expected_log)
    end
    it 'can manage spending money' do
      @ride3.board_rider(@visitor1)
      @ride3.board_rider(@visitor2)
      @ride3.board_rider(@visitor3)

      expect(@visitor1.spending_money).to eq(10)
      expect(@visitor2.spending_money).to eq(5)
      expect(@visitor3.spending_money).to eq(13)
    end
    it "can track total_revenue" do
      @ride3.board_rider(@visitor1)
      @ride3.board_rider(@visitor2)
      @ride3.board_rider(@visitor3)

      expect(@ride3.total_revenue).to eq(2)
    end
  end
end