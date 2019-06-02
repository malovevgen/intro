require_relative 'instance_counter'
require_relative 'valid'

class Station
  include InstanceCounter
  include Valid

  attr_accessor :name, :trains

  NAME_FORMAT = /^[а-я\s]+$/i

  def self.all
    @all ||= []
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    self.class.all << self
    register_instance
  end

  def list(station, trains)
    trains.select do |train|
      station == train.current_station
    end
  end

  private
  # Методы вызываются только из данного класса

  def add_train(train)
    self.trains << train
  end
 
  def counter(type_trains)
    if type_trains
      self.trains.count { |train| train.type == type_trains }
    else
     self.trains.count 
    end
  end

  def delete_train(train)
    self.trains.delete(train)
  end



  def validate!
    raise if name !~ NAME_FORMAT
    raise if name.size > 20
  end
end
