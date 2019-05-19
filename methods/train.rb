class Train
  include Manufacturer
  attr_accessor :speed, :wagons, :number, :route

  @@trains = {}
  
  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
    @@trains[@number] = self
  end

  def self.find(number)
    @@trains[number]
  end


  def hitch(wagon)
    wagons <<  wagon if speed.zero?
  end
 
  def unhook
    self.wagons.pop if speed.zero?
  end

  def set_route(route)
    self.route = route
    @current_station_index = 0
  end 

  def current_station
    self.route.stations[@current_station_index]
  end
  
  def forward
    @current_station_index +=1 unless self.route.last_station?(self.current_station)
  end

  def backward
    @current_station_index -=1 unless self.route.first_station?(self.current_station)
  end  

  private
  # Методы вызываются только из данного класса
  
  def change_speed(speed)
    self.speed = speed
  end

  def stop
    self.speed = 0 unless speed.zero?
  end
end
