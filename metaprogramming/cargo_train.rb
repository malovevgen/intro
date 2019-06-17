class CargoTrain < Train
  def type
    @type = 'cargo'
  end

  def hitch(cargo_wagon)
    super cargo_wagon if cargo_wagon.is_a?(CargoWagon)
  end
end
