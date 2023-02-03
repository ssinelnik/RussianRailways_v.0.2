require_relative 'modules/instance_counter'
require_relative 'modules/manufacturer'
require_relative 'modules/validate'
require_relative 'station'

class Train
  include InstanceCounter
  include Manufacturer
  include Validate

  attr_reader :number, :wagons
  attr_accessor :current_speed

  NUMBER_FORMAT = /^[a-zа-я\d]{3}-*[a-zа-я\d]{2}$/

  @@trains = []

  def self.find(number)
    @@trains.find { |train| train.number == number }
  end

  def initialize(number)
    @number = number
    validate!
    @current_speed = 0
    @wagons = []
    @@trains << self
    register_instance
  end

  def stop
    self.current_speed = 0
  end

  def add_wagon(wagon)
    wagons << wagon if current_speed.zero?
  end

  def delete_wagon(wagon)
    wagons.delete(wagon) if current_speed.zero?
  end

  def set_route(route) # The train gets the route. And the first station is set by default.
    @route = route
    @current_station = @route.stations[0]
    @current_station.take_train(self)
  end

  def move_next
    index = @route.stations.find_index(@current_station)
    @current_station.send_train(self)
    @current_station = @route.stations[index + 1]
    @current_station.take_train(self)
  end

  def move_back
    index = @route.stations.find_index(@current_station)
    @current_station.send_train(self)
    @current_station = @route.stations[index - 1]
    @current_station.take_train(self)
  end

  def now
    @current_station.name
  end

  def next_station
    index = @route.stations.find_index(@current_station)
    @route.stations[index + 1].name
  end

  def previous_station
    index = @route.stations.find_index(@current_station)
    @route.stations[index - 1].name if index.positive?
  end

    # PROTECTED -- PROTECTED -- PROTECTED -- PROTECTED -- PROTECTED -- PROTECTED -- PROTECTED --
  protected

  attr_writer :wagon # Exclude the possibility of adding a wagon to a train, without using a special method.

  def validate!
    raise "Number can't be nil!" if number.nil?
    raise "Number must be 5 symbols!" if number.length < 5
    raise "Invalid number format!" if number !~ NUMBER_FORMAT
  end
end