class Ride
    attr_reader :name, :min_height, :admission_fee, :excitement, :total_revenue, :rider_log

    def initialize(ride_details)
        @name = ride_details[:name]
        @min_height = ride_details[:min_height]
        @admission_fee = ride_details[:admission_fee]
        @excitement = ride_details[:excitement]
        @total_revenue = 0
        @rider_log = Hash.new(0)
    end

    def board_rider(visitor)
        if can_board?(visitor)
            visitor.spending_money -= @admission_fee
            @total_revenue += @admission_fee
            update_rider_log(visitor)
        end
    end

# Helper Methods

    def can_board?(visitor)
        visitor.tall_enough?(min_height) && visitor.preferences.include?(@excitement) && visitor.spending_money >= @admission_fee
    end

    def update_rider_log(visitor)
        if @rider_log[visitor]
            @rider_log[visitor] += 1
        end
    end
end