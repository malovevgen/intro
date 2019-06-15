class Controller
  TRAIN_TYPES = %w[passenger cargo].freeze

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
    puts 'Объем вагона'
    gets.chomp.to_f
  end

  def printing_seats
    puts 'Количество мест в вагоне'
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
    trains.each { |train| puts train.number }
    number = enter_number
    trains.select { |train| train.number == number }.first
  end

  def choose_wagon(wagons)
    puts 'Номера вагонов'
    wagons.each { |wagon| puts wagon.number }
    number = enter_number
    wagons.select { |wagon| wagon.number == number }.first
  end

  def choose_station(stations)
    puts 'Выбрете станцию из списка'
    stations.each_with_index do |station, index|
      puts "#{index}: #{station.name}"
    end
    station_index = gets.chomp.to_i
    stations[station_index]
  end

  def train_list
    puts "Поезд № #{train.number},
    тип-#{train.type} вагонов:#{train.wagons_of_train}"
  end

  def wagon_list
    print "Вагон № #{wagon.number} Тип #{wagon.type}"
    puts "Свободно: #{wagon.free} Занято: #{wagon.filling}"
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
      puts 'Введите добавляемый объем, куб.м'
      value = gets.chomp.to_f
    elsif wagon.type == 'passanger'
      value = 1
    end
    wagon.add(value)
    puts wagon.filling
  end

  def create_train
    number = enter_number
    type = choose_type
    train = Object.const_get("#{type.capitalize}Train").new(number)
    @trains << train
    puts "Поезд #{number}-#{type} создан"
  rescue StandardError
    puts 'Неправильный формат номера'
    retry
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

  def assign_route
    train = choose_train(@trains)
    route = choose_route(@routes)
    train.establish_route(route)
    puts train.route
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

  def create_station
    name = enter_name
    station = Station.new(name)
    @stations << station
    puts "Станция #{name} создана"
  rescue NameError
    puts 'Неправильный формат названия'
    retry
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
    route.stations
    station = choose_station(@stations)
    route.delete_station(station)
  end

  def view_route_sheet
    current_route = choose_route(@routes)
    current_route.list.each_with_index do |station, index|
      puts "#{index}: #{station.name}"
    end
  end

  def view_station_sheet
    station = choose_station(@stations)
    puts station.list(station, @trains)
    station.each_train do |train|
      puts train.to_s
    end
  end

  def stations_info
    @stations.each do |station|
      puts station.name.to_s
      station.list(station, @trains).each(&:train_list)
      train.wagons.each(&:wagon_list)
    end
  end

  def menu_with_exit(commands)
    puts 'Выбирете команду'
    loop do
      commands.each_with_index { |cmd, key| puts "#{key}: #{cmd}" }
      command = gets.chomp.to_i
      case command
      when commands.index('Выход') then break
      else
        yield(commands, command)
      end
    end
  end

  def menu_wagon
    commands = %w[Выход Создать_вагон Добавить_в_вагон]
    menu_with_exit(commands) do |all_commands, current_command|
      case current_command
      when all_commands.index('Создать_вагон') then create_wagon
      when all_commands.index('Добавить_в_вагон') then add_to_wagon
      end
    end
  end

  def menu_train
    commands = %w[
      Выход Создать_поезд Добавить_вагон Отцепить_вагон Назначить_маршрут
      Вперед_по_маршруту Назад_по_маршруту
    ]
    menu_with_exit(commands) do |all_commands, current_command|
      case current_command
      when all_commands.index('Создать_поезд') then create_train
      when all_commands.index('Добавить_вагон') then attach_wagon
      when all_commands.index('Отцепить_вагон') then detach_wagon
      when all_commands.index('Назначить_маршрут') then assign_route
      when all_commands.index('Вперед_по_маршруту') then forward_on_route
      when all_commands.index('Назад_по_маршруту') then back_on_route
      end
    end
  end

  def menu_route
    commands = %w[
      Выход Создать_станцию Создать_маршрут Добавить_станцию Удалить_станцию
      Просмотреть_лист_маршрута Информация_о_станции
    ]
    menu_with_exit(commands) do |all_commands, current_command|
      case current_command
      when all_commands.index('Создать_станцию') then create_station
      when all_commands.index('Создать_маршрут') then create_route
      when all_commands.index('Добавить_станцию') then add_station
      when all_commands.index('Удалить_станцию') then delete_station
      when all_commands.index('Просмотреть_лист_маршрута') then view_route_sheet
      when all_commands.index('Информация_о_станции') then stations_info
      end
    end
  end

  def start
    commands = %w[Выход Вагон Поезд Маршрут]
    menu_with_exit(commands) do |all_commands, current_command|
      case current_command
      when all_commands.index('Вагон') then menu_wagon
      when all_commands.index('Поезд') then menu_train
      when all_commands.index('Маршрут') then menu_route
      end
    end
  end
end
