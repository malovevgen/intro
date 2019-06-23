class PassengerTrain < Train
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :number, :type, String

  def type
    @type = 'passenger'
  end

  def hitch(passenger_wagon)
    super passenger_wagon if passenger_wagon.is_a?(PassengerWagon)
  end
end
