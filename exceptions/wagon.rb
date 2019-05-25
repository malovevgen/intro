class Wagon
  attr_accessor :number

  NUMBER_format = /^\d{6}$/

  def initialize(number)
    @number = number
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    raise if number !~ NUMBER_FORMAT
  end
end
