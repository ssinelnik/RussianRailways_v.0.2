require_relative 'wagon'

class PassengerWagon < Wagon
  attr_reader :type
  attr_accessor :sits

  def initialize(number)
    super
    @type = :passenger
    @sits = yield
    @empty_hash = {}
    (1..@sits).each { |control| @empty_hash[control] = true }
  end

  def show_taken
    @empty_hash.each { |key, value| puts "Place #{key} was taken!" if value == false }
  end

  def show_free
    @empty_hash.each { |key, value| puts "Place #{key} is free for now!" if value == true }
  end

  def return_taken
    num = 0
    @empty_hash.each { |key, value| num += 1 if value == false }
    return num
  end

  def return_free
    num = 0
    @empty_hash.each { |key, value| num += 1 if value == true }
    return num
  end

  def all
    @empty_hash
  end

  def book_place(number)
    @empty_hash[number] = false
  end
end