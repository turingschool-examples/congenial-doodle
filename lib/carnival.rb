class Carnival 
  attr_reader :duration, :rides

  #def self.all
  #  ObjectSpace.each_object(self).to_a
  #end

  def initialize(duration)
    @duration = duration
    @rides = []
  end

  #def self.total_revenue
  #  Carnival.all.sum {|carnival| carnival.total_revenue}
  #end

  def add_ride(ride)
    @rides << ride
  end

  def most_popular_ride
    @rides.max_by {|ride| ride.total_rides}
  end

  def most_profitable_ride
    @rides.max_by {|ride| ride.total_revenue}
  end

  def total_revenue
    @rides.sum {|ride| ride.total_revenue}
  end

  def all_visitors
    visitors = []
    @rides.each do |ride| 
      ride.rider_log.each do |key, _|
        visitors << key if !visitors.include?(key)
      end
    end
    return visitors
  end

  def summary
    summary_hash = Hash.new(0)
    summary_hash[:visitor_count] = self.all_visitors.count
    summary_hash[:revenue_earned] = self.total_revenue

    summary_hash[:visitors] = []

    self.all_visitors.each do |visitor|
      visitor_hash = Hash.new(0)

      visitor_hash[:visitor] = visitor
      visitor_hash[:favorite_ride] = @rides.max_by {|ride| ride.rider_log[visitor]}
      visitor_hash[:total_money_spent] = @rides.sum {|ride| (ride.rider_log[visitor] * ride.admission_fee)}

      summary_hash[:visitors] << visitor_hash
    end

    summary_hash[:rides] = []

    @rides.each do |ride|
      ride_hash = Hash.new(0)

      ride_hash[:ride] = ride
      ride_hash[:riders] = ride.rider_log.keys
      ride_hash[:total_revenue] = ride.total_revenue

      summary_hash[:rides] << ride_hash
    end

    return summary_hash
  end
end