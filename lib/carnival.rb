

class Carnival
  attr_reader :duration, :rides

  def initialize(duration)
    @duration = duration
    @rides = []
  end

  def add_ride(ride)
    @rides << ride
  end

  def most_popular_ride
    @rides.max_by do |ride| 
      ride.rider_log.sum do |key, value| 
        value
      end
    end
  end

  def most_profitable_ride
    @rides.max_by { |ride| ride.total_revenue }
  end

  def total_revenue
    @rides.sum { |ride| ride.total_revenue }
  end

  def summary
    carnival_summary = {}
    visitors = []
    rides = []
    @rides.each do |ride| 
      visitors << ride.rider_log.keys
      rides << ride
    end
    carnival_summary[:visitors_count] = visitors.uniq.count
    carnival_summary[:revenue_earned] = total_revenue
    binding.pry
  end
end