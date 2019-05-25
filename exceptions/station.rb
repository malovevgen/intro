class Station
  attr_accessor :name, :trains

  NAME_FORMAT = /^[а-я\s]+$/i

  def initialize(name)
    @name = name
    @trains = []
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
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
    if type_trains == 'passengers'
     self.trains.count { |train| train.type == 'passengers' }
    elsif type_trains == 'cargo'
     self.trains.count { |train| train.type == 'cargo' } 
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
