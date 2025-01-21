class Ride 
    attr_reader :name, :min_height, :admission_fee, :excitement, :total_revenue, :rider_log, :board_rider

    def initialize(ride_details)
        @name = ride_details[:name]
        @min_height = ride_details[:min_height]
        @admission_fee = ride_details[:admission_fee]
        @excitement = ride_details[:excitement]
        @total_revenue = 0
        @rider_log = {}
    end

    def board_rider(visitor)
        current_money = visitor.spending_money.delete("$").to_i 
        if visitor.height >= @min_height && 
            visitor.preference.include?(@excitement) && 
            current_money >= @admission_fee
            if @rider_log.key?(visitor)
                @rider_log[visitor] += 1
            else
                @rider_log[visitor] = 1
            end

            update_money = current_money - @admission_fee
            visitor.instance_variable_set(:@spending_money, "$#{update_money}")

            @total_revenue += @admission_fee
        end 
    end
end
