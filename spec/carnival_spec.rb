require './spec/spec_helper'

describe Carnival do
  before(:each) do
    @carnival = Carnival.new(14)

    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })

    @visitor1 = Visitor.new('Bruce', 54, '$10')
    @visitor1.add_preference(:gentle)

    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor2.add_preference(:gentle)

    @visitor3 = Visitor.new('Penny', 64, '$15')
    @visitor3.add_preference(:gentle)
    @visitor3.add_preference(:thrilling)

    @ride1.board_rider(@visitor1)
    @ride1.board_rider(@visitor2)
    @ride1.board_rider(@visitor1)

    @ride2.board_rider(@visitor1)
    @ride2.board_rider(@visitor3)

    @ride3.board_rider(@visitor3)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@carnival).to be_a(Carnival)
    end

    it 'has a duration' do
      expect(@carnival.duration).to eq(14)
    end

    it 'has a list of rides' do
      expect(@carnival.rides).to eq([])
    end
  end

  describe '#add_ride' do
    it 'can add rides' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)

      expect(@carnival.rides).to eq([@ride1, @ride2, @ride3])
    end
  end

  describe '#carnival_stats' do
    it 'can display most popular ride' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)

      expect(@ride1.total_rides).to eq(3)
      expect(@ride2.total_rides).to eq(2)
      expect(@ride3.total_rides).to eq(1)

      expect(@carnival.most_popular_ride).to eq(@ride1)
    end

    it 'can display most profitable ride' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)

      expect(@ride1.total_revenue).to eq(3)
      expect(@ride2.total_revenue).to eq(10)
      expect(@ride3.total_revenue).to eq(2)

      expect(@carnival.most_profitable_ride).to eq(@ride2)
    end

    it 'can calculate total revenue across all rides' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)

      expect(@ride1.total_revenue).to eq(3)
      expect(@ride2.total_revenue).to eq(10)
      expect(@ride3.total_revenue).to eq(2)

      expect(@carnival.total_revenue).to eq(15)
    end
  end

  describe '#all_visitors' do
    it 'can list all visitors at the carnival' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)

      expect(@carnival.all_visitors).to eq([@visitor1, @visitor2, @visitor3])
    end
  end

  describe '#summary' do
    it 'can provide a summary hash' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)

      expect(@carnival.summary[:visitor_count]).to eq(3)
      expect(@carnival.summary[:revenue_earned]).to eq(15)

      expect(@carnival.summary[:visitors].count).to eq(3)
      expect(@carnival.summary[:visitors][0][:visitor]).to eq(@visitor1)
      expect(@carnival.summary[:visitors][0][:favorite_ride]).to eq(@ride1)
      expect(@carnival.summary[:visitors][0][:total_money_spent]).to eq(7)

      expect(@carnival.summary[:rides].count).to eq(3)
      expect(@carnival.summary[:rides][0][:ride]).to eq(@ride1)
      expect(@carnival.summary[:rides][0][:riders]).to eq([@visitor1, @visitor2])
      expect(@carnival.summary[:rides][0][:total_revenue]).to eq(3)
      
    end
  end

  describe '::total_revenue' do
    xit 'can track total_revenue across all carnivals' do
      @carnival2 = Carnival.new(14)

      @ride4 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
      @ride5 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
      

      @visitor4 = Visitor.new('Bruce', 54, '$10')
      @visitor4.add_preference(:gentle)

      @visitor5 = Visitor.new('Tucker', 36, '$5')
      @visitor5.add_preference(:gentle)

      @visitor6 = Visitor.new('Penny', 64, '$15')
      @visitor6.add_preference(:gentle)
      @visitor6.add_preference(:thrilling)

      @ride4.board_rider(@visitor1)
      @ride4.board_rider(@visitor2)
      @ride4.board_rider(@visitor1)

      @ride5.board_rider(@visitor1)
      @ride5.board_rider(@visitor3)

      @ride6.board_rider(@visitor3)

      @carnival2.add_ride(@ride4)
      @carnival2.add_ride(@ride5)
      @carnival2.add_ride(@ride6)

      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)

      expect(Carnival.all.count).to eq(2)
      expect(Carnival.total_revenue).to eq(25)
    end
  end
end