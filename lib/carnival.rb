class Carnival 
    attr_reader :duration, :rides

    @@carnivals = []

    def self.all 
        @@carnivals
    end

    def self.total_revenues
        @@carnivals.sum { |carnival| carnival.total_revenue }
    end

    def initialize(duration)
        @duration = duration
        @rides = []
        @@carnivals << self
    end

    def add_ride(ride)
        @rides << ride
    end

    def most_popular_ride
        @rides.max_by { |ride| ride.total_riders }
    end

    def most_profitable_ride
        @rides.max_by { |ride| ride.total_revenue }
    end

    def total_revenue
        @rides.sum { |ride| ride.total_revenue }
    end

    def unique_riders
        ride_visitors = {}

        unique_riders = []

        @rides.each { |ride| ride_visitors[ride] = ride.visitors }

        ride_visitors.each do |ride, visitors|
            visitors.each do |visitor|
                unique_riders << visitor if !unique_riders.include?(visitor)
            end
        end

        unique_riders
    end

    def get_visitor_info(visitor)
        info_hash = {}

        info_hash[:visitor] = visitor
        info_hash[:favorite_ride] = @rides.max_by { |ride| ride.rider_log[visitor] }
        info_hash[:total_money_spent] = visitor.money_spent

        info_hash
    end

    def get_ride_info(ride)
        info_hash = {}

        info_hash[:ride] = ride
        info_hash[:riders] = ride.visitors
        info_hash[:total_revenue] = ride.total_revenue

        info_hash
    end

    def summary
        summary_hash = {}
        riders = unique_riders

        visitor_info = riders.map { |rider| get_visitor_info(rider) }
        ride_info = rides.map { |ride| get_ride_info(ride) }
        
        summary_hash[:visitor_count] = riders.count
        summary_hash[:revenue_earned] = total_revenue
        summary_hash[:visitors] = visitor_info
        summary_hash[:rides] = ride_info

        summary_hash
    end
end