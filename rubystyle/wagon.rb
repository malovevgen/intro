require_relative 'manufacturer'
require_relative 'valid'

class Wagon
  include Manufacturer
  include Valid
  attr_accessor :number, :capacity, :filling

  NUMBER_FORMAT = /^[\d\w]{3}-?[\d\w]{2}$/i

  def initialize(number, capacity)
    @number = number
    @capacity = capacity
    @filling = 0
    validate!
  end

  def add (value)
    value ||= 1
    self.filling += value if (capacity - filling)  >= value
  end

  def free
    capacity - filling
  end   

  private

  def validate!
    raise if number !~ NUMBER_FORMAT
  end
end
