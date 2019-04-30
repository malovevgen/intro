require_relative 'station'
require_relative 'route'
require_relative 'train'

station1 = Station.new('Yaroslavl')
station2 = Station.new('Moscow')
station3 = Station.new('Rostov')

my_route = Route.new(station1, station2)
my_route.add_station(1, station3)


my_train = Train.new(1, 'passengers', 20)  
my_train.unhook
my_train.hitch
my_train.hitch
p my_train.wagons

my_train.set_route(my_route)
#my_train.forward
#my_train.forward
my_train.backward
p my_train.current_station

station2.add_train(my_train)
train2 = Train.new(2, 'freights', 30)
station2.add_train(train2)
train3 = Train.new(3, 'freights', 30)
train4 = Train.new(4, 'freights', 30)
train5 = Train.new(5, 'passengers', 30)
train6 = Train.new(6, 'passengers', 30)
station2.add_train(train3)
station2.add_train(train4)
station2.add_train(train5)
station2.add_train(train6)
station2.delete_train(train3)
p station2.counter('passengers')
p station2.trains

