class Station
  attr_accessor :name, :trains, :type_trains  
  attr_writer :trains_count

  def initialize(name)
    @name = name
    @trains = []
  end
 
  def add_train(train)
    self.trains << train
  end
 
  def counter(type_trains)
    if type_trains == 'passengers'
     self.trains_count = self.trains.select { |train| train.type == 'passengers' }.count
    elsif type_trains == 'freights'
     self.trains_count =  self.trains.select { |train| train.type == 'freights' }.count 
    else
     self.trains_count = self.trains.count 
    end
  end

  def delete_train(train)
    self.trains.delete(train)
  end
end
