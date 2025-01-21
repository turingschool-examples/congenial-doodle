require "./spec/spec_helper.rb"


RSpec.describe Carnival do
  before(:each) do
    @carnival = Carnival.new(14)
    
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
      expect(@carnival).to be_an_instance_of(Carnival)
    end
    it 'has a duration' do
      expect(@carnival.duration).to eq(14)
    end
    it "has an array to store rides" do
      expect(@carnival.rides).to eq([])
    end
  end

  describe "methods" do
    it "can add rides #add_ride" do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)

      expect(@carnival.rides).to eq([@ride1, @ride2])
    end
    it "can find the most popular ride #most_popular_ride" do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)
      
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor3)
      @ride1.board_rider(@visitor1)
      
      @ride3.board_rider(@visitor1)
      @ride3.board_rider(@visitor2)
      @ride3.board_rider(@visitor3)
      @ride3.board_rider(@visitor1)
      expect(@carnival.most_popular_ride).to eq(@ride1)
    end
    it "can find the most profitable ride #most_profitable_ride" do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)
      
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor3)
      @ride1.board_rider(@visitor1)
      
      @ride3.board_rider(@visitor1)
      @ride3.board_rider(@visitor2)
      @ride3.board_rider(@visitor3)
      @ride3.board_rider(@visitor1)

      @ride2.board_rider(@visitor1)
      @ride2.board_rider(@visitor1)
      @ride2.board_rider(@visitor1)
      @ride2.board_rider(@visitor1)
      @ride2.board_rider(@visitor2)
      @ride2.board_rider(@visitor3)
      
      expect(@carnival.most_profitable_ride).to eq(@ride2)
    end
    it 'can find the total revenue of the carnival #carnival_revenue' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)
      
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor1)
      
      @ride3.board_rider(@visitor1)
      @ride3.board_rider(@visitor2)
      @ride3.board_rider(@visitor3)
      @ride3.board_rider(@visitor1)

      @ride2.board_rider(@visitor1)
      @ride2.board_rider(@visitor1)
      @ride2.board_rider(@visitor1)
      @ride2.board_rider(@visitor1)
      @ride2.board_rider(@visitor2)
      @ride2.board_rider(@visitor3)

      expect(@carnival.total_revenue).to eq(14)
    end
    
    xit "can create a summary #summary" do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)     

      #ride1 cost: 1
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor3) #

      #ride2 cost: 5
      @ride2.board_rider(@visitor1)
      @ride2.board_rider(@visitor2) # not enough money
      @ride2.board_rider(@visitor3) # preference wrong
      
      #ride3 cost:2
      @ride3.board_rider(@visitor1) #
      @ride3.board_rider(@visitor2) 
      @ride3.board_rider(@visitor2) 
      @ride3.board_rider(@visitor3) 
      @ride3.board_rider(@visitor3) 
      @ride3.board_rider(@visitor3) 
      @ride3.board_rider(@visitor3) 

      expected = {
        visitor_count: 3,
        revenue_earned: 16,
        visitors: [
          {
          visitor: @visitor1,
          favorite_ride: @ride1,
          total_money_spent: 7
          }, 
            {
            visitor: @visitor2,
            favorite_ride: @ride3,
            total_money_spent: 5
          }, 
            {
            visitor: @visitor3,
            favorite_ride: @ride3,
            total_money_spent: 8
          }], 
        rides: [
          {
            ride: @ride1,
            riders: [@visitor1, @visitor2],
            total_revenue: 3
          },
          {
            ride: @ride2,
            riders: [@visitor1],
            total_revenue: 5
          },
          {
            ride: @ride3,
            riders: [@visitor2, @visitor3],
            total_revenue: 12
          }
        ]}      
      expect(@carnival.favorite_ride(@visitor1)).to eq(@ride1)
      expect(@carnival.summary).to eq(expected)
    end
  end
end