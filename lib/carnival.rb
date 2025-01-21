class Carnival
  attr_reader :name, :duration, :rides, :visitors

  def initialize(name, duration)
    @name = name
    @duration = duration
    @rides = []
    @visitors = []
    @summary = {
      visitor_count: 0,
      revenue_earned: 0,
      visitors: [],
      rides: []
    }
  end

  def add_ride(ride)
    @rides << ride
  end

  def add_visitor(visitor)
    @visitors << visitor
    @summary[:visitor_count] += 1
  end

  def most_popular_ride
    @rides.max_by do |ride|
      ride.total_trips
    end
  end

  def most_profitable_ride
    @rides.max_by do |ride|
      ride.total_revenue
    end
  end

  def total_revenue
    @rides.sum do |ride|
      ride.total_revenue
    end
  end

  def summary
    @summary[:revenue_earned] = total_revenue
    @summary[:visitors] = @visitors
    @summary[:rides] = @rides

    # @rides.each do |ride|
    #   @summary[:rides] << { ride: ride, riders: ride.rider_log, total_revenue: ride.total_revenue}
    # end

    @summary
  end
end