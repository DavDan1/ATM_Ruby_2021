class Atm
    attr_accessor :funds

    def initialize
        @funds=1000
    end

    def withdraw(amount)
        @funds -= amount
        
    end

end