class MainMenu
  def initialize
    @stations = []
    @routes = []
    @trains = []
    @wagons = []
  end

  def start
    loop do
      open_menu

      user_choice_1 = gets.to_i

      case user_choice_1
      when 1
        new_station
      when 2
        new_train
      when 3
        print "Create or change a route? (create/change) -> "
        user_choice_2 = gets.chomp.downcase

        case user_choice_2
        when "create"
          new_route
        when "change"
          change_route
        end

      when 4
        pinup_route
      when 5
        attach_detach_wagons
      when 6
        run_train
      when 7
        big_list
      when 8
        new_wagon
      when 999
        show_for_developers
      end
      break if user_choice_1 == 0
    end
  end

  def new_station
    print "Enter station name -> "
    station_name = gets.chomp
    station_name = Station.new(station_name)
    @stations << station_name
    puts "The station #{station_name.name} was created!"
  end

  # add a check so that several trains with the same numbers cannot be created
  def new_train
    print "Enter train number (5 symbols length) -> "
    train_number = gets.chomp
    print "Enter train type (cargo/passenger) -> "
    train_type = gets.chomp.to_sym
      if train_type == :passenger
        train_number = PassengerTrain.new(train_number)
        @trains << train_number
        puts "The train #{train_number.number} was created!"
      elsif train_type == :cargo
        train_number = CargoTrain.new(train_number)
        @trains << train_number
        puts "The train #{train_number.number} was created!"
      else
        raise "Wrong train type!"
      end
    rescue RuntimeError => e
      puts "Check input!
      Error: #{e}"
      puts "Try again please."
    retry
  end

  def new_route
    print "Enter route name -> "
    route_name = gets.chomp

    print"Enter first station name -> "
    first_station_name = gets.chomp

    print"Enter last station name -> "
    last_station_name = gets.chomp

    route_name = Route.new(route_name, @stations.find { |s| s.name == first_station_name}, @stations.find { |s| s.name == last_station_name})
    @routes << route_name
    puts "The route #{route_name.name} was created!"
  end

  def change_route
    print "Enter route name -> "
    route_name = gets.chomp

    print "Add or delete station? (add/delete) -> "
    user_choice_3 = gets.chomp

    print "Station name -> "
    station_name = gets.chomp

    if user_choice_3 == "add"
      @routes.find { |r| r.name == route_name }.add_station(@stations.find { |s| s.name == station_name })
      puts "Station #{station_name} was successfully added to route #{route_name}!"
    elsif user_choice_3 == "delete"
      @routes.find { |r| r.name == route_name }.delete_station(@stations.find { |s| s.name == station_name })
      puts "Station #{station_name} was successfully deleted from route #{route_name}!"
    else
      puts "Error!"
    end
  end

  def pinup_route
    print "Enter route name -> "
    route_name = gets.chomp

    print "Enter train number -> "
    train_number = gets.chomp

    @trains.find { |t| t.number == train_number }.set_route(@routes.find { |r| r.name == route_name})
    puts "Route #{route_name} was set up for train #{train_number}!"
  end

  def attach_detach_wagons
    print "Attach or detach wagons? (attach/detach) -> "
    user_choice_4 = gets.chomp

    print "Enter train number -> "
    train_number = gets.chomp

    print "Enter wagon number -> "
    wagon_number = gets.chomp

    if user_choice_4 == "attach"
      @trains.find { |t| t.number == train_number}.add_wagon(@wagons.find { |w| w.number == wagon_number})
      puts "Wagon #{wagon_number} was attached to train #{train_number}!"
    elsif user_choice_4 == "detach"
      @trains.find { |t| t.number == train_number}.delete_wagon(@wagons.find { |w| w.number == wagon_number})
      puts "Wagon #{wagon_number} was detached from train #{train_number}!"
    else
      puts "Error!"
    end
  end

  def run_train
    print "Enter train number -> "
    train_number = gets.chomp

    print "Move the train to the next or previous station? (next/previous) -> "
    user_choice_6 = gets.chomp

    if user_choice_6 == "next"
      @trains.find { |t| t.number == train_number }.move_next
      puts "Train #{train_number} move to next station in route successfully!"
    elsif user_choice_6 == "previous"
      @trains.find { |t| t.number == train_number }.move_back
      puts "Train #{train_number} move to previous station in route successfully!"
    else
      puts "Error!"
    end
    puts "Train #{train_number} is on #{@trains.find { |t| t.number == train_number }.now} station."
  end

  # show trains on stations
  def big_list
    puts "Choose station in the list:"
    number = 0
    @stations.each do |s|
      number += 1
      puts "#{number}. #{s.name}"
    end
    print "Enter station name -> "
    station_name = gets.chomp
    @stations.find { |s| s.name == station_name }.trains_on_station.each { |t| puts "Train #{t.number} is on #{station_name} in the moment." }
  end

  def new_wagon
    print "Enter wagon number -> "
    wagon_number = gets.chomp

    print "Enter wagon type (cargo/passenger) -> "
    user_choice_5 = gets.chomp

    if user_choice_5 == "passenger"
      wagon_number = PassengerWagon.new(wagon_number)
      @wagons << wagon_number
      puts "The passenger wagon #{wagon_number.number} was created!"
    elsif user_choice_5 == "cargo"
      wagon_number = CargoWagon.new(wagon_number)
      @wagons << wagon_number
      puts "The cargo wagon #{wagon_number.number} was created!"
    end
  end

  def show_for_developers
    puts "1. Stations: #{@stations}"
    puts "2. Routes: #{@routes}"
    puts "3. Trains: #{@trains}"
    puts "4. Wagons: #{@wagons}"
  end

  def open_menu
    text_menu = "
      Enter [1] to create a station.
      Enter [2] to create a train.
      Enter [3] to create or change a route.
      Enter [4] to set a train route.
      Enter [5] to attach or detach wagons.
      Enter [6] to move the train by route.
      Enter [7] to watch BIG LIST (stations and trains).
      Enter [8] to create an wagon.
      Enter [0] to exit.
      --------------------------------------------------
      Enter [999] to run show_for_developers."
    puts text_menu
  end
end