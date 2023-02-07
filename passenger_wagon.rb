require_relative 'wagon'

class PassengerWagon < Wagon
  attr_reader :type
  attr_accessor :user_sits, :taken_seat, :free_seat, :number_of_sits

  # @number_of_sits = Hash.new # empty hash

  def initialize(number)
    super
    @type = :passenger
    @user_sits = user_sits_query
  end

  def user_sits_query
    print "Enter number of passenger sits for this wagon -> "
    user_quantity = gets.chomp.to_i
    return user_quantity
  end

  def booking_sits
    print "Enter place number -> "
    user_place = gets.chomp.to_i
    puts user_place

    # @number_of_sits = Hash.new # empty hash

    fail "Sorry, your place is not on the list!" if user_place > @user_sits # make realization with validate!

    (1..@user_sits).each { |number|
      # number_of_sits[number] = true # all places are free by default
      if user_place == number && @number_of_sits[number] != false
        @number_of_sits[number] = false # the place is taken by somebody
      elsif user_place != number
        @number_of_sits[number] = true # the place is still free
      else
        puts "Sorry, your place is already taken!"
        break
      end
      # puts number.inspect
    }
    puts number_of_sits
  end
end