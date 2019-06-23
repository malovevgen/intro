require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation
  extend Accessors

  @@trains = {}

  attr_accessor :wagons, :number, :route
  attr_accessor_with_history :speed

  NUMBER_FORMAT = /^[\d\w]{3}-?[\d\w]{2}$/i.freeze

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :number, :type, String

  def self.find(number)
    @@trains[number]
  end

  def initialize(number)
    @number = number
    @wagons = []
    self.speed = 0
    validate!
    @@trains[@number] = self
    register_instance
  end

  def hitch(wagon)
    wagons << wagon if speed.zero?
  end

  def unhook
    wagons.pop if speed.zero?
  end

  def establish_route(route)
    self.route = route
    @current_station_index = 0
  end

  def current_station
    route.stations[@current_station_index]
  end

  def forward
    @current_station_index += 1 unless route.last_station?(current_station)
  end

  def backward
    @current_station_index -= 1 unless route.first_station?(current_station)
  end

  def wagons_of_train
    @wagons.length
  end

  def each_wagon
    wagons.each { |wagon| yield(wagon) }
  end

  private

  # Methods are called only from this class

  def change_speed(speed)
    self.speed = speed
  end

  def stop
    self.speed = 0 unless speed.zero?
  end
end
