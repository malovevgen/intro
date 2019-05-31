class PassengerWagon < Wagon
  attr_accessor :seats, :seats_filling
 
  def initialize(number, seats)
    super(number)
    @seats = seats
    @seats_filling = 0
  end
  
  def type
    "passenger"
  end

  def take_seat
    self.seats_filling += 1 if seats > seats_filling
  end
end
