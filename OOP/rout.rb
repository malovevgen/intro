class Rout
  attr_accessor :stations
  attr_reader :first_station, :last_station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [@first_station, @last_station]
  end

  def add_station(index, station) 
    self.stations.insert(index, station)
  end

  def erase_station(station)
    self.stations.delete(station)
  end

  def list
    self.stations.each { |station| puts station.name }
  end

end
