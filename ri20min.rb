#!/usr/bin/env ruby

class MegaGreeter
  attr_accessor :names

  # Create the Object
  def initialize(names = "World")
    @names = names
  end

  # Say hi to everyone
  def say_hi
    if @names.nil?
      puts "..."
    elsif @names.respond_to?("each")
      # @names is a list of some kind, iterate!
      @names.each do |name|
        puts "Hello #{name}!"
      end
    else
      puts "Hello #{@names}"
    end
  end

  # Say bye to everyone
  def say_bye
    if @names.nil?
      puts "..."
    elsif @names.respond_to?("join")
      # @names is a list of some kind, iterate!
      puts "Goodbye #{names.join(", ")}. I will come back!"
    else
      puts "Goodbye #{@names}. I will come back!"
    end
  end

end

puts "start.."
puts __FILE__
puts $0
puts "end.."

# if __FILE__ == $0
  mg = MegaGreeter.new
  mg.say_hi
  mg.say_bye

  mg.names = "Bella"
  mg.say_hi
  mg.say_bye

  mg.names = ["Bella", "Siky", "Baby"]
  mg.say_hi
  mg.say_bye

  mg.names = nil
  mg.say_hi
  mg.say_bye
# end