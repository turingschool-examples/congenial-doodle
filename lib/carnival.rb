class Carnival
  attr_reader :duration, :rides

  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date 
    @rides = []
  end

  def add_ride(ride)
    @rides << ride
  end

  def list_rides
    ride_names = []
    @rides.each do |ride|
      ride_names << ride.name
    end
    ride_names
  end

  def most_popular_ride
    most_popular = nil
    max_rides = 0

    @rides.each do |ride|
      total_rides = ride.rider_log.values.sum
      if total_rides > max_rides
        most_popular = ride
        max_rides = total_rides
      end
    end

    most_popular
  end

  def most_profitable_ride
    most_profitable = nil
    max_revenue = 0

    @rides.each do |ride|
      if ride.total_revenue > max_revenue
        most_profitable = ride
        max_revenue = ride.total_revenue
      end
    end

    most_profitable
  end

  def total_revenue
    total = 0

    @rides.each do |ride|
      total += ride.total_revenue
    end

    total
  end

  def carnival_open?(current_date)
    current_date >= @start_date && current_date <= @end_date
  end

  def duration
    (@end_date - @start_date).to_i 
  end
end