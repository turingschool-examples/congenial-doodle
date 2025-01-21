# frozen_string_literal: true

# Create a visitor for the carnival
class Visitor
  attr_reader :name, :height, :spending_money, :preferences

  def initialize(name, height, spending_money)
    @name = name
    @height = height
    @spending_money = spending_money.delete_prefix('$').to_i
    @preferences = []
  end

  def add_preference(pref)
    @preferences << pref
  end

  def tall_enough?(minimum_height)
    @height > minimum_height
  end

  def spend_money(amount)
    @spending_money -= amount
  end
end
