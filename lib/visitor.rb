class Visitor 
    attr_reader :name, :height, :preference
    attr_accessor :spending_money
    
    def initialize(name, height, spending_money)
        @name = name 
        @height = height 
        @spending_money = spending_money
        @preference = []
    end
     
    def add_preference(preference)
        @preference << preference
    end

    def tall_enough?(min_height)
        @height >= min_height
    end

end