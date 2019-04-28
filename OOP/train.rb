class Train
  attr_accessor :speed, :type, :wagons, :number, :rout, :current_station_index

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def change_speed(speed)
    self.speed = speed
  end

  def stop
    self.speed = 0
  end

  def change_wagons(action)
    if action ==  "unhook"
     self.wagons -= 1
    elsif action == "hitch" 
     self.wagons += 1
    end
  end

  def set_rout(rout)
    self.rout = rout
    self.current_station_index = 0
  end

  def current_station
    self.rout.stations[self.current_station_index]
  end

  def move(direction)
    case direction
    when "forward"
      self.current_station_index +=1 unless (self.current_station == self.rout.last_station)
    when "backward"
      self.current_station_index -=1 unless (self.first_station == self.rout.last_station)
    end
  end

end
