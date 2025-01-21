class Visitor
  attr_reader :name, :height, :spending_money, :preferences

  def initialize(name, height, spending_money)
    @name = name
    @height = height
    @spending_money = parse_spending_money(spending_money)
    @preferences = []
  end

  def add_preference(preference)
    @preferences << preference
  end

  def tall_enough?(min_height)
    @height >= min_height
  end

  def deduct_spending_money(amount)
    @spending_money -= amount
  end

  private

  def parse_spending_money(spending_money)
    spending_money.delete('$').to_i
  end
end
