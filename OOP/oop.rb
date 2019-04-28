require_relative 'station'
require_relative 'rout'
require_relative 'train'

station1 = Station.new('Yaroslavl')
station2 = Station.new('Moscow')
station3 = Station.new('Rostov')

my_rout = Rout.new(station1, station2)
my_rout.add_station(1, station3)
#my_rout.list

my_train = Train.new(1, "passengers", 20)  
my_train.change_wagons("unhook")
my_train.wagons

my_train.set_rout(my_rout)
my_train.move('forward')
my_train.current_station

station2.add_train(my_train)
train2 = Train.new(2, "freights", 30)
station2.add_train(train2)
p station2.trains_count
p station2.trains
