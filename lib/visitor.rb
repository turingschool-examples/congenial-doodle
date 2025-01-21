

class Visitor
  attr_reader :name, :height, :preferences, :spending_money
  attr_writer :spending_money
  def initialize(name, height, money)
    @name = name
    @height = height
    @spending_money = money.delete("$").to_i
    @preferences = []
  end

  def add_preference(preference)
    @preferences << preference
  end

  def tall_enough?(min_height)
    @height >= min_height
  end
end