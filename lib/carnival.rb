class Carnival
  attr_reader :name, :duration, :rides, :total_revenue

  @@all_carnivals = []

  def initialize(name, duration)
    @name = name
    @duration = duration

    @rides = []
    @total_revenue = 0

    @@all_carnivals << self     #For iteration 4
  end

  def add_ride(ride)
    @rides << ride
  end

  def most_popular_ride()
    #Based on total NON-unique riders, so can utilize Ride's rider_log(s)
    #Nothing stated about handling ties, so just worry about returning first max
    @rides.max do |ride1, ride2|
      ride1.total_riders() <=> ride2.total_riders()
    end
  end

  def most_profitable_ride()
    @rides.max do |ride1, ride2|
      ride1.total_revenue <=> ride2.total_revenue
    end
  end

  def total_revenue()
    @rides.sum do |ride|
      ride.total_revenue
    end
  end

  def generate_summary_report()
    summary_hash = {}
    
    #Find total unique visitors (store in array for other use later too):
    all_visitors = @rides.map do |ride|
      ride.rider_log.keys
    end.flatten.uniq
    summary_hash[:visitor_count] = all_visitors.length

    summary_hash[:revenue_earned] = total_revenue()

    #Construct visitor sub-array
    summary_hash[:visitors] = []
    all_visitors.each do |visitor|
      #Favorite ride:
      summary_hash[:visitors] << {visitor: visitor, favorite_ride: visitor.favorite_ride(), total_money_spent: visitor.money_spent()}
    end

    #Construct ride sub-array:
    summary_hash[:rides] = []
    @rides.each do |ride|
      summary_hash[:rides] << {ride: ride, riders: ride.rider_log.keys, total_revenue: ride.total_revenue}
    end

    # binding.pry

  end

  def self.total_revenues()
    @@all_carnivals.sum do |carnival|
      carnival.total_revenue()
    end
  end

end
