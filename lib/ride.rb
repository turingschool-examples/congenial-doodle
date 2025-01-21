class Ride
  attr_reader :name, :min_height, :admission_fee, :excitement, :rider_log

  def initialize(details)
    @name = details[:name]
    @min_height = details[:min_height]
    @admission_fee = details[:admission_fee]
    @excitement = details[:excitement]
    @rider_log = Hash.new(0)
  end

  def board_rider(visitor)
    if can_board?(visitor)
      visitor.deduct_spending_money(@admission_fee)
      @rider_log[visitor] += 1
    end
  end

  def total_revenue
    @rider_log.sum { |visitor, rides| rides * @admission_fee }
  end

  private

  def can_board?(visitor)
    visitor.tall_enough?(@min_height) &&
      visitor.preferences.include?(@excitement) &&
      visitor.spending_money >= @admission_fee
  end
end
