class PassengerTrain < Train
  def type
    @type = 'passenger'
  end

  def hitch(passenger_wagon)
    super passenger_wagon if passenger_wagon.is_a?(PassengerWagon)
  end
end
