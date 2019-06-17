require_relative 'instance_counter'
require_relative 'valid'

class Station
  include InstanceCounter
  include Valid

  attr_accessor :name, :trains

  NAME_FORMAT = /^[а-я\s]+$/i.freeze

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

  def each_train
    trains.each { |train| yield(train) }
  end

  private

  # Methods are called only from this class

  def add_train(train)
    trains << train
  end

  def counter(type_trains)
    if type_trains
      trains.count { |train| train.type == type_trains }
    else
      trains.count
    end
  end

  def delete_train(train)
    trains.delete(train)
  end

  def validate!
    raise if name !~ NAME_FORMAT
    raise if name.size > 20
  end
end
