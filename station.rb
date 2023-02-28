# may be should add method, that delete wrong station from @@stations[]

require_relative 'modules/instance_counter'
require_relative 'modules/validate'

class Station
  include InstanceCounter
  include Validate

  attr_reader :name, :trains_on_station

  @@stations = []

  # return all stations, method for Station class !
  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    validate!
    @trains_on_station = []
    @@stations << self
    register_instance
  end

  def test_functional_block(functional_block)
    @trains_on_station.each { |element| functional_block.call }
  end

  def trains_by_type(type) # type = class name (CargoTrain or PassengerTrain)
    @trains_on_station.each { |train| puts train.number if train.kind_of?(type) } # kind_of?(Class Object)
  end

  def send_train(train)
    @trains_on_station.delete(train)
  end

  def take_train(train)
    @trains_on_station << train
  end

  # PRIVATE -- PRIVATE -- PRIVATE -- PRIVATE -- PRIVATE -- PRIVATE -- PRIVATE --
  private

  def validate!
    raise "Name can't be nil!" if name.nil?
  end
end