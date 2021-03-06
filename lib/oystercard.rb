class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1

  attr_reader :balance, :journeys

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    fail "Maximum balance exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance =+ amount
  end
         
  def in_journey?
    !!@entry_station
  end
      
  def touch_in(station)
    fail "Insufficient balance to touch in" if balance < MINIMUM_CHARGE
    @journeys << { entry_station: station }
  end
    
  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    @journeys.last[:exit_station] = station
  end
    
  private

  def deduct(amount)
    @balance -= amount
  end
end
