require_relative 'instance_counter'

class Route
  include InstanceCounter
  attr_accessor :stations, :first_station, :last_station, :station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [@first_station, @last_station]
    register_instance
  end

  def add_station(index, station)
    stations.insert(index, station)
  end

  def delete_station(station)
    stations.delete(station)
  end

  def list
    stations
  end

  def first_station?(station)
    station == first_station
  end

  def last_station?(station)
    station == last_station
  end
end
