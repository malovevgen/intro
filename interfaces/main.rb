require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

TRAIN_TYPES = ['passenger', 'cargo']
stations = []
trains = []
routes = []
wagons = []
route_stations = []

passenger_wagon1 = PassengerWagon.new(1001)
passenger_wagon2 = PassengerWagon.new(1002)
passenger_wagon3 = PassengerWagon.new(1003)
cargo_wagon1 = CargoWagon.new(2001)
cargo_wagon2 = CargoWagon.new(2002)
cargo_wagon3 = CargoWagon.new(2003)
wagons << passenger_wagon1
wagons << passenger_wagon2
wagons << passenger_wagon3
wagons << cargo_wagon1
wagons << cargo_wagon2
wagons << cargo_wagon3 

def choose_train_type
  puts 'Выбирете тип поезда'
  TRAIN_TYPES.each_with_index do |cmd, key|
    puts "#{key}: #{cmd}"
  end
  command = gets.chomp.to_i
  TRAIN_TYPES[command]
end

def enter_number
  puts 'Введите номер'
  gets.chomp.to_i 
end

def choose_route(routes)
  puts 'Выбирете маршрут'
  routes.each_with_index do |route, index|
    puts "#{index}: #{route.first_station.name} - #{route.last_station.name}" 
  end
  route_index = gets.chomp.to_i
  routes[route_index]
end

def choose_train(trains)
  puts 'Номера поездов'
  trains.each{ |train| puts train.number }
  number = enter_number
  trains.select{ |train| train.number == number }.first
end

def choose_wagon(wagons)
  puts 'Выбирете номер вагона из списка'
  wagons.each_with_index do |wagon, index|
    puts "#{index}: #{wagon.type} № #{wagon.number}" 
  end
  wagon_index = gets.chomp.to_i
  wagons[wagon_index]
end

def choose_station(stations)
  puts 'Выбрете станцию из списка'
  stations.each_with_index do |station, index|
    puts "#{index}: #{station.name}"
  end  
  station_index = gets.chomp.to_i
  stations[station_index]
end 

commands = [
'Выход из программы',
'Создать поезд',
'Назначить маршрут',
'Добавить вагон',
'Отцепить вагон',
'Вперед по маршруту',
'Назад по маршруту',
'Создать маршрут',
'Добавить станцию',
'Удалить станцию',
'Просмотреть лист маршрута',
'Создать станцию',
'Просмотреть лист станции'
]
puts 'Выбирете команду'
loop do
  commands.each_with_index do |cmd, key|
    puts "#{key}: #{cmd}"
  end  
  command = gets.chomp.to_i
  puts "#{commands[command]}"
  case command
    when commands.index('Выход из программы')
      break
    when commands.index('Создать поезд')
      type = choose_train_type
      number = enter_number
      if type == 'passenger'
        train = PassengerTrain.new(number)
      elsif type == 'cargo'
        train = CargoTrain.new(number)
      end
      trains << train
    when commands.index('Назначить маршрут')
      train = choose_train(trains)
      route = choose_route(routes)
      train.set_route(route)
      print train.route
    when commands.index('Добавить вагон')
      current_train = choose_train(trains)
      current_wagon = choose_wagon(wagons) 
      current_train.hitch(current_wagon)
      puts current_train.wagons
    when commands.index('Отцепить вагон')
      current_train = choose_train(trains)
      current_train.unhook
    when commands.index('Вперед по маршруту')
      current_train = choose_train(trains)
      current_train.forward
      puts current_train.current_station.name
    when commands.index('Назад по маршруту')
      current_train = choose_train(trains)
      current_train.backward
      puts current_train.current_station.name
    when commands.index('Создать маршрут')
      puts 'Первая станция'
      first_station = choose_station(stations)
      puts 'Последняя станция'
      last_station = choose_station(stations)
      route = Route.new(first_station, last_station)
      routes << route
    when commands.index('Добавить станцию')
      route = choose_route(routes)
      puts 'Новая станция'
      station = choose_station(stations)
      puts 'Введите порядковый номер новой станции'
      number = gets.chomp.to_i
      route.add_station(number - 1, station)
    when commands.index('Удалить станцию')
      route = choose_route(routes)
      route_stations = route.stations
      station =  choose_station(stations) 
      route.delete_station(station)
    when commands.index('Просмотреть лист маршрута')
      current_route = choose_route(routes)
      current_route.list.each_with_index do |station, index|
        puts "#{index}: #{station.name}"
      end
    when commands.index('Создать станцию')
      puts 'Введите название станции'
      name = gets.chomp
      station = Station.new(name)
      stations << station
    when commands.index('Просмотреть лист станции')
      station = choose_station(stations)
      puts station.list(station, trains) 
  end
end
