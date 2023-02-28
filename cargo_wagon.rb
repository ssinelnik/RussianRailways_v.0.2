require_relative 'wagon'

class CargoWagon < Wagon
  attr_reader :type
  attr_accessor :start_vol

  def initialize(number)
    super
    @type = :cargo
    @start_vol = yield
    @current_vol = @start_vol
  end

  def wagon_loading(load)
    @current_vol -= load if @current_vol >= load
  end

  def free_vol
    @start_vol - @current_vol
  end

  def taken_load
    @current_vol
  end
end