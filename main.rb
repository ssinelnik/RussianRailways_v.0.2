# ---------- modules ----------
require_relative 'modules/instance_counter'
require_relative 'modules/validate'
require_relative 'modules/manufacturer'

# ---------- classes ----------
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'main_menu'

# script_1 :
m = MainMenu.new # create new menu

train_1 = PassengerTrain.new("12345") # create passenger train
m.trains << train_1 # add to array 'trains[]'

train_2 = CargoTrain.new("67890") # create cargo train
m.trains << train_2 # # add to array 'trains[]'

wagon_1_p = PassengerWagon.new(13) {36} # create passenger wagon
m.wagons << wagon_1_p # add to array 'wagons[]'
m.wagons_h[13] = wagon_1_p # add to hash 'wagons_h{}'

wagon_2_p = PassengerWagon.new(14) {54} # create passenger wagon
m.wagons << wagon_2_p # add to array 'wagons[]'
m.wagons_h[14] = wagon_2_p # add to hash 'wagons_h{}'

wagon_1_c = CargoWagon.new(15) {78} # create cargo wagon
m.wagons << wagon_1_c # add to array 'wagons[]'
m.wagons_h[15] = wagon_1_c # add to hash 'wagons_h{}'

wagon_2_c = CargoWagon.new(16) {78} # create cargo wagon
m.wagons << wagon_2_c # add to array 'wagons[]'
m.wagons_h[16] = wagon_2_c # add to hash 'wagons_h{}'

train_1.add_wagon(wagon_1_p) # attach wagon_1_p to train_1
train_1.add_wagon(wagon_2_p) # attach wagon_2_p to train_1
train_2.add_wagon(wagon_1_c) # attach wagon_1_c to train_2
train_2.add_wagon(wagon_2_c) # attach wagon_2_c to train_2

station_1 = Station.new("Chelyabinsk") # create 1th station
station_2 = Station.new("StPetersburg") # create 2th station
station_3 = Station.new("Novosibirsk") # create 3th station
station_4 = Station.new("Orenburg") # create 4th station
station_5 = Station.new("Vladivostok") # create 5th station
station_6 = Station.new("Moscow") # create 6th station

m.stations << station_1 # add station_1 to array 'stations[]'
m.stations << station_2 # add station_2 to array 'stations[]'
m.stations << station_3 # add station_3 to array 'stations[]'
m.stations << station_4 # add station_4 to array 'stations[]'
m.stations << station_5 # add station_5 to array 'stations[]'
m.stations << station_6 # add station_6 to array 'stations[]'

route_1 = Route.new("Chelyabinsk - Novosibirsk", station_1, station_3) # create route
m.routes << route_1 # add route_1 to array 'routes[]'
route_2 = Route.new("Orenburg - Moscow", station_4, station_6) # create route
m.routes << route_2 # add route_2 to array 'routes[]'

route_1.add_station(station_2) # add station_2 to route_1
route_2.add_station(station_5) # add station_5 to route_2

train_1.set_route(route_1) # pinup route_1 for train_1
train_2.set_route(route_2) # pinup route_2 for train_2

# booking some places in passenger wagons :
m.wagons_h[13].book_place(1)
m.wagons_h[13].book_place(2)
m.wagons_h[13].book_place(3)
m.wagons_h[13].book_place(4)
m.wagons_h[14].book_place(7)
m.wagons_h[14].book_place(9)
m.wagons_h[14].book_place(11)
m.wagons_h[14].book_place(45)

# loading some space in cargo wagons :
m.wagons_h[15].wagon_loading(30)
m.wagons_h[16].wagon_loading(75)

num_s = 0 # station number
m.stations.each do |s|
  num_s += 1
  puts "#{num_s}. #{s.name}:"
  s.trains_on_station.each do |t|
    puts "   Train number: #{t.number}. Current speed: #{t.current_speed}. Wagons: #{t.wagons.size}."
    t.wagons.each do |w|
      puts "    -> Wagon number: #{w.number}. Wagon type: #{w.type}. All seats: #{w.all.size}.\n       Taken seats: #{w.return_taken}. Free seats: #{w.return_free}." if w.type == :passenger
      puts "    -> Wagon number: #{w.number}. Wagon type: #{w.type}. Total volume: #{w.start_vol}.\n       Taken volume #{w.taken_load}. Free volume: #{w.free_vol}." if w.type == :cargo
    end
  end
end

# MainMenu.new.start
