require 'pry'

class Carnival 
    attr_reader :duration, :rides, :visitors

    def initialize(duration)
        @duration = duration
        @rides = []
        @visitors = []
    end

    def add_ride(ride)
        @rides << ride
    end

    def most_popular_ride
        @rides.max_by do |ride| 
            ride.rider_log.values.sum
        end
    end

    def most_profitable_ride
        @rides.max_by do |ride|
            ride.total_revenue
        end
    end

    def total_revenue
        @rides.map do |ride|
            ride.total_revenue
        end.sum
    end

    def add_visitor(visitor) #helper method
        @visitors << visitor
    end

    # def self.summary
    #     summary = {}
    #     binding.pry
        
    # end
end