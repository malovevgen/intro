class Station
  attr_accessor :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end
 
  def list
    self.trains.each { |train| puts train.number }
  end

  private
  # Методы вызываются только из данного класса

  def add_train(train)
    self.trains << train
  end
 
  def counter(type_trains)
    if type_trains == 'passengers'
     self.trains.select { |train| train.type == 'passengers' }.count
    elsif type_trains == 'cargo'
     self.trains.select { |train| train.type == 'freights' }.count 
    else
     self.trains.count 
    end
  end

  def delete_train(train)
    self.trains.delete(train)
  end
end
