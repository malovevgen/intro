class Train
  attr_accessor :speed, :wagons, :number, :route
  
  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
  end
 
  def unhook
    self.wagons.pop
  end

  def set_route(route)
    self.route = route
    @current_station_index = 0
  end 

  def current_station
    self.route.stations[@current_station_index]
  end

  protected
  # Методы вызываются только из дочерних классов

  def forward
    @current_station_index +=1 unless self.current_station == self.route.last_station
  end

  def backward
    @current_station_index -=1 unless self.current_station == self.route.first_station
  end

  private
  # Методы вызываются только из данного класса
  
  def change_speed(speed)
    self.speed = speed
  end

  def stop
    self.speed = 0
  end
end
