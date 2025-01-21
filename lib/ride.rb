class Ride 
  attr_reader :name, :min_height, :admission_fee, :excitement, :total_revenue, :rider_log

  def initialize(attributes)
    @name = attributes[:name]
    @min_height = attributes[:min_height]
    @admission_fee = attributes[:admission_fee]
    @excitement = attributes[:excitement]
    @total_revenue = 0
    @rider_log = Hash.new(0)
  end

  def board_rider(rider)
    return if !(rider.tall_enough?(@min_height)) || !(rider.preferences.include?(@excitement)) || (rider.spending_money < @admission_fee)
    @rider_log[rider] += 1
    @total_revenue += @admission_fee
    rider.spending_money -= @admission_fee
  end

  
  def total_rides
    @rider_log.sum {|_, rides| rides}
  end
end