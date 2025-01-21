# frozen_string_literal: true

# Create the carnival!
class Carnival
  attr_reader :duration, :rides

  @@all = [] # rubocop:disable Style/ClassVars

  def initialize(duration)
    @duration = duration
    @rides = []
    @@all << self
  end

  def add_ride(ride)
    @rides << ride
  end

  def most_popular_ride
    return if @rides.empty?

    @rides.max_by do |ride|
      ride.rider_log.values.sum
    end
  end

  def most_profitable_ride
    return if @rides.empty?

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
    {
      visitor_count: visitors_array.length,
      revenue_earned: total_revenue,
      visitors: visitors_array,
      rides: rides_array
    }
  end

  def self.total_revenues
    @@all.sum do |carnival|
      carnival.total_revenue
    end
  end

  private

  def visitors_array
    visitors = @rides.each_with_object([]) do |ride, unique_visitors|
      ride.rider_log.each_key do |rider|
        unique_visitors << rider unless unique_visitors.include?(rider)
      end
    end
    visitors.each_with_object([]) do |visitor, visitor_array|
      visitor_array << visitor_hash(visitor)
    end
  end

  def visitor_hash(visitor)
    favorite_ride = @rides.max_by do |ride|
      next 0 unless ride.rider_log[visitor]

      ride.rider_log[visitor]
    end
    total_money_spent = @rides.sum do |ride|
      next 0 unless ride.rider_log[visitor]

      ride.rider_log[visitor] * ride.admission_fee
    end
    { visitor: visitor, favorite_ride: favorite_ride, total_money_spent: total_money_spent }
  end

  def rides_array
    @rides.map do |ride|
      {
        ride: ride,
        riders: ride.rider_log.keys,
        total_revenue: ride.total_revenue
      }
    end
  end
end
