class CargoTrain < Train
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :number, :type, String

  def type
    @type = 'cargo'
  end

  def hitch(cargo_wagon)
    super cargo_wagon if cargo_wagon.is_a?(CargoWagon)
  end
end
