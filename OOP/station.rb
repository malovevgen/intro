class Station
  attr_accessor :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    self.trains << train
  end

  def trains_count
    passengers_count = 0
    freights_count = 0
    self.trains.each do |train|
      if train.type == 'passengers'
        passengers_count += 1
      elsif train.type == 'freights'
        freights_count += 1
      end
    end
    [passengers_count, freights_count]
  end

  def erase_train(train)
    self.trains.delete(train)
  end

end
