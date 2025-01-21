# frozen_string_literal: true

# Create a ride for the carnival
class Ride
  attr_reader :name, :min_height, :admission_fee, :excitement, :total_revenue, :rider_log

  def initialize(ride_params)
    @name = ride_params[:name]
    @min_height = ride_params[:min_height]
    @admission_fee = ride_params[:admission_fee]
    @excitement = ride_params[:excitement]
    @total_revenue = 0
    @rider_log = {}
  end

  def board_rider(visitor)
    return unless visitor.tall_enough?(@min_height) &&
                  visitor.spending_money >= @admission_fee &&
                  visitor.preferences.include?(@excitement)

    if @rider_log[visitor]
      @rider_log[visitor] += 1
    else
      @rider_log[visitor] = 1
    end
    @total_revenue += @admission_fee
    visitor.spend_money(@admission_fee)
  end
end
