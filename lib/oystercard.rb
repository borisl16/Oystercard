class Oystercard
    MAXIMUM_BALANCE = 90
    BALANCE_LIMIT = 20
    MINIMUM_LIMIT = 1

    attr_reader :balance

    def initialize
        @balance = 0
        @limit = 0
        @in_journey = 0
    end

    def top_up(amount)
        fail "Maximum balance exceeded" if amount + balance > MAXIMUM_BALANCE
        @balance =+ amount
    end

    def deduct(amount)
        @balance -= amount
    end
       
    def in_journey?
        false
    end
    
        
    def touch_in
        fail "Insufficient balance to touch in" if balance < MINIMUM_LIMIT
        @in_journey = true
      end
      

   def touch_out

   end

end
