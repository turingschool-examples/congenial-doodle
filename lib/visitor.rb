class Visitor
  attr_reader :name, :height, :spending_money, :preferences
  attr_writer :spending_money

  def initialize(name, height, spending_money)
    @name = name
    @height = height
    @spending_money = spending_money.delete('$').to_i
    @preferences = []
  end

  def add_preference(trait)
    @preferences << trait
  end

  def tall_enough?(req_height)
    if @height >= req_height
      true
    else
      false
    end
  end
end