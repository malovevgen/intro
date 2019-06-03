class Controller
  TRAIN_TYPES = ['passenger', 'cargo']

  def initialize
    @stations = []
    @routes = []
    @trains = []
    @wagons = []
  end

  def choose_type
    puts 'Выбирете тип:1,enter, если грузовой; enter, если пассажирский'
    index_type = gets.chomp.to_i
    if index_type == 1 
      TRAIN_TYPES[1]
    else
      TRAIN_TYPES[0]
    end    
  end

  def enter_number
    puts 'Введите номер в формате ххх(-)хх,где х - цифра или латинская буква'
    gets.chomp
  end

  def printing_volume
    puts "Объем вагона"
    gets.chomp.to_f
  end

  def printing_seats
    puts "Количество мест в вагоне"
    gets.chomp.to_i
  end

  def enter_name
    puts 'Введите название русскими буквами. Длина- не более 20 символов'
    gets.chomp.capitalize
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
    puts 'Номера вагонов'
    wagons.each{ |wagon| puts wagon.number }
    number = enter_number
    wagons.select{ |wagon| wagon.number == number }.first
  end

  def choose_station(stations)
    puts 'Выбрете станцию из списка'
    stations.each_with_index do |station, index|
      puts "#{index}: #{station.name}"
    end  
    station_index = gets.chomp.to_i
    stations[station_index]
  end

  def create_train
    type = choose_type
    number = enter_number
    if type == 'passenger'
      train = PassengerTrain.new(number)
    elsif type == 'cargo'
      train = CargoTrain.new(number)
    end
    @trains << train
    puts "Поезд #{number}-#{type} создан"
  rescue
    puts 'Неправильный формат номера'
    retry
  end

  def assign_route
    train = choose_train(@trains)
    route = choose_route(@routes)
    train.set_route(route)
    puts train.route
  end

  def attach_wagon
    current_train = choose_train(@trains)
    current_wagon = choose_wagon(@wagons) 
    current_train.hitch(current_wagon)
    puts current_train.wagons
  end
  
  def detach_wagon
    current_train = choose_train(@trains)
    current_train.unhook
  end

  def forward_on_route
    current_train = choose_train(@trains)
    current_train.forward
    puts current_train.current_station.name
  end

  def back_on_route
    current_train = choose_train(@trains)
    current_train.backward
    puts current_train.current_station.name
  end  

  def create_route
    puts 'Первая станция'
    first_station = choose_station(@stations)
    puts 'Последняя станция'
    last_station = choose_station(@stations)
    route = Route.new(first_station, last_station)
    @routes << route
  end

  def add_station
    route = choose_route(@routes)
    puts 'Новая станция'
    station = choose_station(@stations)
    puts 'Введите порядковый номер новой станции'
    number = gets.chomp.to_i
    route.add_station(number - 1, station)
  end

  def delete_station
    route = choose_route(@routes)
    route_stations = route.stations
    station =  choose_station(@stations) 
    route.delete_station(station)
  end

  def view_route_sheet
    current_route = choose_route(@routes)
    current_route.list.each_with_index do |station, index|
      puts "#{index}: #{station.name}"
    end
  end

  def create_station
    name = enter_name
    station = Station.new(name)
    @stations << station
    puts "Станция #{name} создана"
  rescue
    puts 'Неправильный формат названия'
    retry
  end

  def view_station_sheet
    station = choose_station(@stations)
    #puts station.list(station, @trains)
    puts station.trains_with_block(station, @trains)
  end

  def create_wagon
    type = choose_type
    number = enter_number
    if type == 'passenger'
      seats = printing_seats
      wagon = PassengerWagon.new(number, seats)
    elsif type == 'cargo'
      volume = printing_volume
      wagon = CargoWagon.new(number, volume)
    end
    @wagons << wagon
  end

  def add_to_wagon
    wagon = choose_wagon(@wagons)
    if wagon.type == 'cargo'
      puts "Введите добавляемый объем, куб.м" 
      value = gets.chomp.to_f
    elsif wagon.type == 'passanger'
      value = 1
    end
    wagon.add(value)
    puts wagon.filling
  end

  def stations_info
    @stations.each do |station|
      puts "#{station.name} "
      station.list(station, @trains).each do |train|
        puts "Поезд № #{train.number},тип-#{train.type} вагонов:#{train.wagons_of_train}"
        train.wagons.each do |wagon|
          print "Вагон № #{wagon.number} Тип #{wagon.type}"
          puts "Свободно: #{wagon.free} Занято: #{wagon.filling}"
        end
      end
    end
  end
     
  def start
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
    'Просмотреть лист станции',
    'Создать вагон',
    'Добавить в вагон',
    'Информация о станции'
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
          create_train
        when commands.index('Назначить маршрут')
          assign_route
        when commands.index('Добавить вагон')
          attach_wagon
        when commands.index('Отцепить вагон')
          detach_wagon
        when commands.index('Вперед по маршруту')
          forward_on_route
        when commands.index('Назад по маршруту')
          back_on_route
        when commands.index('Создать маршрут')
          create_route
        when commands.index('Добавить станцию')
          add_station
        when commands.index('Удалить станцию')
          delete_station
        when commands.index('Просмотреть лист маршрута')
          view_route_sheet
        when commands.index('Создать станцию')
          create_station
        when commands.index('Просмотреть лист станции')
          view_station_sheet
        when commands.index('Создать вагон')
          create_wagon 
        when commands.index('Добавить в вагон')
          add_to_wagon
        when commands.index('Информация о станции')
          stations_info
      end
    end
  end
end
