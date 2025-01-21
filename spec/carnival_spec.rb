require 'spec_helper'

RSpec.describe Carnival do
  it 'exists and has attributes' do
    carnival = Carnival.new(14)

    expect(carnival).to be_a(Carnival)
    expect(carnival.duration).to eq(14)
    expect(carnival.rides).to eq([])
  end

  it 'can add rides and list them' do
    carnival = Carnival.new(14)
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })

    carnival.add_ride(ride1)
    carnival.add_ride(ride2)

    expect(carnival.rides).to eq([ride1, ride2])
  end

  it 'can determine the most popular ride' do
    carnival = Carnival.new(14)
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor2 = Visitor.new('Tucker', 36, '$5')

    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)

    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor1)

    carnival.add_ride(ride1)
    carnival.add_ride(ride2)

    expect(carnival.most_popular_ride).to eq('Carousel')
  end

  it 'can determine the most profitable ride' do
    carnival = Carnival.new(14)
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor2 = Visitor.new('Tucker', 36, '$5')

    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)

    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor1)
    ride2.board_rider(visitor1)

    carnival.add_ride(ride1)
    carnival.add_ride(ride2)

    expect(carnival.most_profitable_ride).to eq('Ferris Wheel')
  end

  it 'can calculate the total revenue earned from all its rides' do
    carnival = Carnival.new(14)
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor2 = Visitor.new('Tucker', 36, '$5')

    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)

    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor1)
    ride2.board_rider(visitor1)

    carnival.add_ride(ride1)
    carnival.add_ride(ride2)

    expect(carnival.total_revenue).to eq(8)
  end
end
