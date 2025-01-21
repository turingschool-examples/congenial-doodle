class Visitor
  attr_reader :name, :height, :spending_money, :preferences, :rides_ridden

  def initialize(name, height, spending_money_string)
    @name = name
    @height = height
    @spending_money = spending_money_string.delete_prefix("$").to_i
    @starting_money = @spending_money   #Make a copy of initial value for future reference

    @preferences = []
    @rides_ridden = Hash.new(0)     #Key is ride object, value is number of times ridden
  end

  def add_preference(preference)
    @preferences << preference
  end

  def tall_enough?(threshold_height)
    @height >= threshold_height
  end
  
  def pay_fee(ride, amount)
    #Track actual ride object as well for other methods' use
    #Return true if successful, false if insufficient funds
    if amount <= @spending_money
      @spending_money -= amount
      @rides_ridden[ride] += 1
      return true
    else
      return false
    end
  end

  def favorite_ride()
    @rides_ridden.max_by do |ride, count|
      count
    end[0]    #Extract the key (i.e. Ride object)
  end

  def money_spent()
    @starting_money - @spending_money
  end

end
