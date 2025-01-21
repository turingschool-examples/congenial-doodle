require './spec/spec_helper'

describe Ride do
  before(:each) do
    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
    @visitor1 = Visitor.new('Bruce', 54, '$10')
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor3 = Visitor.new('Penny', 64, '$15')
  end

  describe '#initialize' do
    it 'exists' do
      expect(@ride1).to be_a(Ride)
    end

    it 'has a name' do
      expect(@ride1.name).to eq('Carousel')
    end

    it 'has a min_height' do
      expect(@ride1.min_height).to eq(24)
    end

    it 'has an admission fee' do
      expect(@ride1.admission_fee).to eq(1)
    end

    it 'has an excitement level' do
      expect(@ride1.excitement).to eq(:gentle)
    end

    it 'tracks total revenue' do
      expect(@ride1.total_revenue).to eq(0)
    end

  end


  describe '#board_rider' do
    it 'can board riders' do
      @visitor1.add_preference(:gentle)
      @visitor2.add_preference(:gentle)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)

      expect(@ride1.rider_log).to eq({@visitor1 => 2, @visitor2 => 1})
    end

    it 'reduces rider spending money by the admission fee' do
      @visitor1.add_preference(:gentle)
      @visitor2.add_preference(:gentle)

      expect(@visitor1.spending_money).to eq(10)
      expect(@visitor2.spending_money).to eq(5)
      expect(@ride1.admission_fee).to eq(1)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)

      expect(@visitor1.spending_money).to eq(8)
      expect(@visitor2.spending_money).to eq(4)
    end

    it 'cannot board riders who do not match the ride preference' do
      @visitor1.add_preference(:gentle)
      @visitor2.add_preference(:thrilling)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)

      expect(@ride1.rider_log).to eq({@visitor1 => 1})
  
    end

    it 'cannot board riders who are not tall enough' do
      @visitor2.add_preference(:thrilling)

      expect(@ride3.min_height).to eq(54)
      expect(@visitor2.height).to eq(36)

      @ride3.board_rider(@visitor2)

      expect(@ride3.rider_log).to eq({})
    end

    it 'cannot board riders who do not have enough spending money' do
      @visitor1.add_preference(:gentle)

      @visitor1.spending_money = 0
      @ride1.board_rider(@visitor1)

      expect(@ride1.rider_log).to eq({})
    end
  end

  describe '#totals' do
    it 'can calculate total revenue' do
      @visitor1.add_preference(:gentle)
      @visitor2.add_preference(:gentle)

      expect(@ride1.admission_fee).to eq(1)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)

      expect(@ride1.total_revenue).to eq(3)
    end

    it 'can calculate total rides' do
      @visitor1.add_preference(:gentle)
      @visitor2.add_preference(:gentle)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)

      expect(@ride1.total_rides).to eq(3)
    end
  end

end