class Ride
  attr_reader :name, :min_height, :admission_fee, :excitement, :rider_log, :total_revenue

  def initialize(details)
    @name = details[:name]
    @min_height = details[:min_height]
    @admission_fee = details[:admission_fee]
    @excitement = details[:excitement]
    @rider_log = {}
    @total_revenue = 0
  end

  def board_rider(visitor)
    if visitor.tall_enough?(@min_height) && 
       visitor.preferences.include?(@excitement) && 
       visitor.spending_money >= @admission_fee
  
      visitor.spend_money(@admission_fee)
  
      @rider_log[visitor] = @rider_log[visitor].to_i + 1
  
      @total_revenue += @admission_fee
    end
  end

  def rider_names
    names = []
    @rider_log.each do |visitor, count|
      names << visitor.name
    end
    names
  end
end