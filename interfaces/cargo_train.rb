class CargoTrain < Train
  attr_accessor :type

  def type
    @type = "cargo"
  end
  
  def hitch(cargo_wagon)
    wagons << cargo_wagon if cargo_wagon.is_a?(CargoWagon)
  end
end
