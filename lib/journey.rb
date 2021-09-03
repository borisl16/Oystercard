require 'journey'
class Journey

  PENALTY_FARE = 6

  def initialize
    @journeys = []
    @station
  end 

  def complete?
  end

  def fare
    PENALTY_FARE
  end

  def finish(station)
    @station << station
  end 
  

  
 
end 
 

