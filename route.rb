require_relative 'modules/instance_counter'
require_relative 'modules/validate'

class Route
  include InstanceCounter
  include Validate

  attr_reader :stations, :name

  def initialize(name, first_station, last_station)
    @name = name
    validate!
    @stations = [first_station, last_station]
    register_instance
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    stations.delete(station)
  end

  def station_list
    stations.each { |station| puts station.name }
  end

  # PRIVATE -- PRIVATE -- PRIVATE -- PRIVATE -- PRIVATE -- PRIVATE -- PRIVATE --
  private

  attr_writer :stations # Exclude the possibility of adding a station to a route without using a special method for this operation.

  def validate!
    raise "Name can't be nil!" if name.nil?
  end
end