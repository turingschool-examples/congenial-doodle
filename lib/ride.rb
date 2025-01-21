require 'pry'

class Ride
    attr_reader :name, :min_height, :admission_fee, :excitement, :total_revenue, :rider_log

    def initialize(ride_details)
        @name = ride_details[:name]
        @min_height = ride_details[:min_height]
        @admission_fee = ride_details[:admission_fee]
        @excitement = ride_details[:excitement]
        @total_revenue = 0
        @rider_log = {}
    end

    def board_rider(rider)
        if rider.height >= @min_height && rider.preferences.include?(@excitement) && rider.spending_money >= @admission_fee
            rider.spending_money -= @admission_fee
            @total_revenue += @admission_fee
            if @rider_log.key?(rider)
                @rider_log[rider] += 1
            else
                @rider_log[rider] = 1
            end
        else
            p "Rider does not meet rider requirements"
        end
    end
end