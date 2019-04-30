class Train
  attr_accessor :speed, :type, :wagons, :number, :list, :route, :current_station_index

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

  def unhook
    self.wagons -= 1
  end

  def hitch 
    self.wagons += 1
  end
    
  def set_route(route)
    self.route = route
    self.current_station_index = 0
  end

  def current_station
    self.route.stations[self.current_station_index]
  end

  def forward
    self.current_station_index +=1 unless (self.current_station == self.route.last_station)
  end

  def backward
    self.current_station_index -=1 unless (self.current_station == self.route.first_station)
  end
end
