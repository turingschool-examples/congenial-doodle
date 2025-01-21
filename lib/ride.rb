class Ride
  attr_reader :name, 
              :min_height, 
              :admission_fee, 
              :excitement, 
              :total_revenue
              :rider_log

  def initialize(details)
    @name = details[:name]
    @min_height = details[:min_height]
    @admission_fee = details[:admission_fee]
    @excitement = details[:excitement]
    @total_revenue = 0
    @rider_log = Hash.new(0)
  end

  def rider_log
    @rider_log
  end

  def board_rider(rider)
    if rider.height >= @min_height && rider.preferences.include?(@excitement) && rider.spending_money >= @admission_fee
      rider.spending_money -= @admission_fee
      @total_revenue += @admission_fee
      @rider_log[rider] += 1 
    end
  end

  def total_trips
    @rider_log.sum do |rider, trips|
      trips
    end
  end
end