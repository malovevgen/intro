class Route
  attr_accessor :stations, :first_station, :last_station
  attr_reader 
  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [@first_station, @last_station]
  end

  def add_station(index, station) 
    self.stations.insert(index, station)
  end

  def delete_station(station)
    self.stations.delete(station)
  end

  def list
    self.stations.each { |station| puts station.name }
  end
end
