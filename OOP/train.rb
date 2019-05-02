class Train
  attr_accessor :speed, :type, :wagons, :number, :list, :route
  
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
    @current_station_index = 0
  end 

  def current_station
    self.route.stations[@current_station_index]
  end

  def forward
    @current_station_index +=1 unless self.current_station == self.route.last_station
  end

  def backward
    @current_station_index -=1 unless self.current_station == self.route.first_station
  end
end
