class Ride 
    attr_reader :name,
                :min_height,
                :admission_fee,
                :excitement,
                :total_revenue,
                :rider_log

    def initialize(ride_params)
        @name = ride_params[:name]
        @min_height = ride_params[:min_height]
        @admission_fee = ride_params[:admission_fee]
        @excitement = ride_params[:excitement]
        @total_revenue = 0
        @rider_log = Hash.new(0)
    end

    def board_rider(rider)
        return if !rider.has_preference?(@excitement)
        return if !rider.tall_enough?(@min_height)
        return if !rider.pay_admission(@admission_fee)
        
        @rider_log[rider] += 1
        @total_revenue += admission_fee
    end

    def total_riders
        @rider_log.sum { |rider, times_ridden| times_ridden }
    end

    def visitors
        @rider_log.keys
    end
end