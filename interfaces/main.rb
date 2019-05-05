require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

train_types = ['passenger', 'cargo']
stations = []
trains = []
routes = []
wagons = []
#line 16..27 для создания массива вагонов
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
      puts 'Выбирете тип поезда'
      train_types.each_with_index do |cmd, key|
      puts "#{key}: #{cmd}"
      end
      command = gets.chomp.to_i
      type = train_types[command]
      puts 'Введите номер поезда'
      number = gets.chomp.to_i
      if type == 'passenger'
        train = PassengerTrain.new(number)
      elsif type == 'cargo'
        train = CargoTrain.new(number)
      end
      trains << train
    when commands.index('Назначить маршрут')
      puts 'Номера поездов'
      trains.each{ |train| puts train.number }
      puts 'Введите номер поезда'
      number = gets.chomp.to_i
      current_train = trains.select{ |train| train.number == number }.first
      puts 'Выбирете маршрут'
      routes.each_with_index{ |route, index| puts "#{index}: #{route.first_station} - #{route.last_station}" }
      route_index = gets.chomp.to_i
      current_route = routes[route_index]
      current_train.set_route(current_route)
      print current_train.route
    when commands.index('Добавить вагон')
      puts 'Номера поездов'
      trains.each{|train| puts train.number}
      puts 'Введите номер поезда'
      number = gets.chomp.to_i
      current_train = trains.select{ |train| train.number == number}.first
      puts 'Выбирете номер вагона из списка'
      wagons.each_with_index{ |wagon, index| puts "#{index}: #{wagon.type} № #{wagon.number}" }
      wagon_index = gets.chomp.to_i
      current_wagon = wagons[wagon_index] 
      current_train.hitch(current_wagon)
      puts current_train.wagons
    when commands.index('Отцепить вагон')
      puts 'Номера поездов'
      trains.each{ |train| puts train.number }
      puts 'Введите номер поезда'
      number = gets.chomp.to_i
      current_train = trains.select{ |train| train.number == number}.first
      current_train.unhook
    when commands.index('Вперед по маршруту')
      puts 'Номера поездов'
      trains.each{ |train| puts train.number }
      puts 'Введите номер поезда'
      number = gets.chomp.to_i
      current_train = trains.select{ |train| train.number == number }.first
      current_train.forward
      puts current_train.current_station.name
    when commands.index('Назад по маршруту')
      puts 'Номера поездов'
      trains.each{ |train| puts train.number }
      puts 'Введите номер поезда'
      number = gets.chomp.to_i
      current_train = trains.select{ |train| train.number == number }.first
      current_train.backward
      puts current_train.current_station.name
    when commands.index('Создать маршрут')
      puts 'Выбрете первую станцию из списка'
      stations.each_with_index{ |station, index| puts "#{index}: #{station.name}"}
      first_station_index = gets.chomp.to_i
      first_station = stations[first_station_index]
      puts 'Выбрете последнюю станцию из списка'
      stations.each_with_index{ |station, index| puts "#{index}: #{station.name}"}
      last_station_index = gets.chomp.to_i
      last_station = stations[last_station_index]
      route = Route.new(first_station, last_station)
      routes << route
    when commands.index('Добавить станцию')
      puts 'Выбирете маршрут'
      routes.each_with_index{ |route, index| puts "#{index}: #{route.first_station.name} - #{route.last_station.name}" }
      route_index = gets.chomp.to_i
      current_route = routes[route_index]
      current_route.stations.each_with_index{ |station, index| puts "Порядковый номер станции: #{index + 1}, название #{station.name}"}
      puts 'Введите порядковый номер новой станции'
      number = gets.chomp.to_i
      puts 'Выбрете новую станцию из списка'
      stations.each_with_index{ |station, index| puts "#{index}: #{station.name}"}
      new_station_index = gets.chomp.to_i
      new_station = stations[new_station_index]
      current_route.add_station(number - 1, new_station )
      current_route.stations.each_with_index{ |station, index| puts "Порядковый номер станции: #{index + 1}, название #{station.name}"}
    when commands.index('Удалить станцию')
      puts 'Выбирете маршрут'
      routes.each_with_index{ |route, index| puts "#{index}: #{route.first_station.name} - #{route.last_station.name}" }
      route_index = gets.chomp.to_i
      current_route = routes[route_index]
      current_route.stations.each_with_index{ |station, index| puts "Порядковый номер станции: #{index}, название #{station.name}"}
      puts 'Введите порядковый номер удаляемой станции'
      number = gets.chomp.to_i
      del_station = stations[number]
      current_route.delete_station(del_station)
    when commands.index('Просмотреть лист маршрута')
      puts 'Выбрете маршрут из списка'
      routes.each_with_index{ |route, index| puts "#{index}: #{route.first_station.name} - #{route.last_station.name}" }
      route_index = gets.chomp.to_i
      current_route = routes[route_index]
      current_route.list
    when commands.index('Создать станцию')
      puts 'Введите название станции'
      name = gets.chomp
      station = Station.new(name)
      stations << station
    when commands.index('Просмотреть лист станции')
      puts 'Выбрете станцию из списка'
      stations.each_with_index{ |station, index| puts "#{index}: #{station.name}"}
      station_index = gets.chomp.to_i
      current_station = stations[station_index]
      current_station.list
  end
end
