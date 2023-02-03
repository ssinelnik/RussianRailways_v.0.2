require_relative 'modules/instance_counter'
require_relative 'modules/manufacturer'
require_relative 'modules/validate'

class Wagon
  include Manufacturer
  include Validate
  include InstanceCounter

  attr_reader :number

  def initialize(number)
    @number = number
    validate!
    register_instance
  end

  # PROTECTED -- PROTECTED -- PROTECTED -- PROTECTED -- PROTECTED -- PROTECTED -- PROTECTED --
  protected

  def validate!
    raise "Number can't be nil!" if number.nil?
  end
end