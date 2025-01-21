require './lib/visitor'
require './lib/ride'
require './lib/carnival'
require 'pry'
require 'date'

RSpec.describe Visitor do
  before(:each) do
    @visitor1 = Visitor.new('Bruce', 54, '$10')
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor3 = Visitor.new('Penny', 64, '$15')
    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
    @carnival = Carnival.new(Date.new(2025, 1, 1), Date.new(2025, 1, 5))

      
    @carnival.add_ride(@ride1)
    @carnival.add_ride(@ride2)
    @carnival.add_ride(@ride3)
  
      
    @visitor1.add_preference(:gentle)
    @visitor2.add_preference(:gentle)
    @visitor2.add_preference(:thrilling)
    @visitor3.add_preference(:thrilling)
  
      
    @ride1.board_rider(@visitor1) 
    @ride1.board_rider(@visitor1) 
    @ride2.board_rider(@visitor2) 
    @ride3.board_rider(@visitor3) 
    @ride3.board_rider(@visitor3) 
    @ride3.board_rider(@visitor3)
    @ride3.board_rider(@visitor3)
    
  end
  
  it 'returns a carnivals duration' do
    expect(@carnival.duration).to eq(4)   
  end

  it 'returns that the carnival is open on specific date' do
    specific_date = Date.new(2025, 1, 3)
    expect(@carnival.carnival_open?(specific_date)).to eq(true)
  end

  it 'returns that the carnival is no longer open' do
    specific_date = Date.new(2025, 1, 6) 
    expect(@carnival.carnival_open?(specific_date)).to eq(false)
  end

  it 'can add rides to the carnival' do
  
    expect(@carnival.rides).to eq([@ride1, @ride2, @ride3]) 
  end

  it 'lists all rides in the carnival' do
  
    expect(@carnival.list_rides).to eq(['Carousel', 'Ferris Wheel', 'Roller Coaster']) 
  end

  it 'returns the ride that has been ridden the most' do
    expect(@carnival.most_popular_ride).to eq(@ride3) 
  end

  it 'returns the ride that has earned the most total revenue' do
    expect(@carnival.most_profitable_ride).to eq(@ride3) 
  end

  it 'calculates the total revenue earned from all rides' do
    
    expect(@carnival.total_revenue).to eq(15)
  end

end