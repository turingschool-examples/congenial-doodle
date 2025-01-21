require 'pry'

class Visitor
    attr_reader :name, :height, :preferences
    attr_accessor :spending_money

    def initialize(name, height, spending_money)
        @name = name
        @height = height
        @spending_money = spending_money.delete("$").to_f
        @preferences = []
    end

    def add_preference(preference)
        @preferences << preference
    end

    def tall_enough?(height_threshold)
        if height_threshold <= @height
            true
        else
            false
        end
    end
end