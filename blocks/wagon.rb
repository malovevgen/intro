require_relative 'manufacturer'
require_relative 'valid'

class Wagon
  include Manufacturer
  include Valid
  attr_accessor :number

  NUMBER_FORMAT = /^[\d\w]{3}-?[\d\w]{2}$/i

  def initialize(number)
    @number = number
    validate!
  end

  private

  def validate!
    raise if number !~ NUMBER_FORMAT
  end
end
