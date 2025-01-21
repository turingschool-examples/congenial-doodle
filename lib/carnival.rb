class Carnival

  attr_accessor :duration, :rides, :visitors_list, :visitor_count, :total_revenues
  
  
  def initialize(duration)
    @duration = duration
    @visitors_list = Hash.new{ |hash, key| hash[key] = { favorite_ride: nil, money_spent: 0 } }
    @visitor_count = 0
    @total_revenue = 0
    @rides = []
  end

  def add_ride(ride)
    @rides << ride
  end

  def most_popular_ride
    @rides.max_by do |ride|
      ride.times_ridden
    end
  end

  def most_profitable_ride
    @rides.max_by do |ride|
      ride.total_revenue
    end
  end

  def total_revenue
    @total_revenue = 0
    @total_revenue += @rides.sum do |ride|
      ride.total_revenue
    end
    @total_revenue
  end

#   def summary
#     summary = {
#       'Visitor count' => @visitor_count,
#       'Revenue earned' => @total_revenues,
#       'List of visitors' => @visitors_list
#     }
#   end

#   private

#   def visitor_count
#     @rides.each do |ride|
#       @visitor_count += ride.rider_log.keys.count
#     end
#     @visitor_count
#   end

#   def list_of_visitors
#     @rides.each do |ride|
#       ride.rider_log.each do |rider|
#         @visitors_list[rider]
#       end
#     end
#   end
end