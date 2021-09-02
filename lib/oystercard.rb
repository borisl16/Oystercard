class Oystercard
    MAXIMUM_BALANCE = 90
    BALANCE_LIMIT = 20
    MINIMUM_CHARGE = 1

    attr_reader :balance

    def initialize
        @balance = 0
        @limit = 0
        @in_journey = false
    end

    def top_up(amount)
        fail "Maximum balance exceeded" if amount + balance > MAXIMUM_BALANCE
        @balance =+ amount
    end

           
    def in_journey?
        false
    end
    
        
    def touch_in
        fail "Insufficient balance to touch in" if balance < MINIMUM_CHARGE
        @in_journey = true
      end
      

      def touch_out
        deduct(MINIMUM_CHARGE)
        @in_journey = false
      end
      
      private

      def deduct(amount)
        @balance -= amount
    
      end

end
