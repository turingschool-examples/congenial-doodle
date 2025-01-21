class Ride
  attr_reader :name, :min_height, :admission_fee, :excitement, :total_revenue, :rider_log

  def initialize(ride_info_hash)
    @name = ride_info_hash[:name]
    @min_height = ride_info_hash[:min_height]
    @admission_fee = ride_info_hash[:admission_fee]
    @excitement = ride_info_hash[:excitement]

    @total_revenue = 0
    @rider_log = Hash.new(0)
  end

  def board_rider(visitor)
    if visitor.tall_enough?(@min_height) && visitor.preferences.include?(@excitement) && visitor.spending_money >= @admission_fee
      rider_log[visitor] += 1
      #Make the visitor pay up!  (And add to revenue)
      visitor.pay_fee(self, @admission_fee)   #Should always return true given our test above (or could factor that in above directly)
      @total_revenue += @admission_fee
    end
  end

  def total_riders()
    @rider_log.sum do |rider, count|
      count
    end
  end
end
