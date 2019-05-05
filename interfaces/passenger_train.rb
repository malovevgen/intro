class PassengerTrain < Train
  attr_accessor :type

  def type
    @type = "passenger"
  end
  
  def hitch(passenger_wagon)
    self.wagons.push(passenger_wagon) if passenger_wagon.is_a?(PassengerWagon)
  end
end
