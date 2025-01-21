class Ride

attr_reader :name, :min_height, :admission_fee, :excitement, :total_revenue, :rider_log, :times_ridden

  def initialize(attributes)
    @name = attributes[:name]
    @min_height = attributes[:min_height]
    @admission_fee = attributes[:admission_fee]
    @excitement = attributes[:excitement]
    @total_revenue = 0
    @rider_log = Hash.new(0)
    @times_ridden = 0
  end

  def board_rider(rider)
    if rider.spending_money >= @admission_fee && rider.tall_enough?(@min_height) && rider.preferences.include?(@excitement)
      @rider_log[rider] += 1
      rider.spending_money -= @admission_fee
      @total_revenue += @admission_fee
      @times_ridden += 1
    end
  end
end