require_relative 'wagon'

class PassengerWagon < Wagon
  attr_reader :type

  def initialize(number)
    super
    @type = :passenger
  end
end