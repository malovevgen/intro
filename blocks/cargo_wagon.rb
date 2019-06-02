class CargoWagon < Wagon
  attr_accessor :volume,  :load_volume, :volume_filling
  attr_reader  :free_volume

  def initialize(number, volume)
    super(number)
    @volume = volume
    @volume_filling = 0
  end

  def type
    "cargo"
  end

  def load (load_volume)
    self.volume_filling += load_volume if (volume - volume_filling)  >= load_volume
  end

  def free
    volume - volume_filling
  end   
end
