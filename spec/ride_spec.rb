require 'spec_helper'

RSpec.describe Ride do
  it 'exists and has attributes' do
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })

    expect(ride1).to be_a(Ride)
    expect(ride1.name).to eq('Carousel')
    expect(ride1.min_height).to eq(24)
    expect(ride1.admission_fee).to eq(1)
    expect(ride1.excitement).to eq(:gentle)
    expect(ride1.rider_log).to eq({})
  end

  it 'can board riders and log them' do
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor2 = Visitor.new('Tucker', 36, '$5')

    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)

    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor1)

    expect(ride1.rider_log).to eq({
      visitor1 => 2,
      visitor2 => 1
    })
    expect(visitor1.spending_money).to eq(8)
    expect(visitor2.spending_money).to eq(4)
  end

  it 'can calculate total revenue' do
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor2 = Visitor.new('Tucker', 36, '$5')

    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)

    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor1)

    expect(ride1.total_revenue).to eq(3)
  end

  it 'does not board riders who do not meet the requirements' do
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor2 = Visitor.new('Tucker', 36, '$5')
    visitor3 = Visitor.new('Penny', 64, '$15')

    visitor1.add_preference(:thrilling) # Does not match ride excitement
    visitor2.add_preference(:gentle)    # Matches all conditions
    visitor3.add_preference(:gentle)    # Matches all conditions

    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor3)

    expect(ride1.rider_log).to eq({
      visitor2 => 1,
      visitor3 => 1
    })
    expect(visitor1.spending_money).to eq(10) # Not deducted
    expect(visitor2.spending_money).to eq(4)  # Deducted
    expect(visitor3.spending_money).to eq(14) # Deducted
  end
end
