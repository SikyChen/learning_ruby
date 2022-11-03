#!/usr/bin/env ruby

class MegaGreeter
  # 声明可读写的变量 names
  attr_accessor :names

  # 相当于构造函数，对类 new 时调用
  def initialize(names = "World")
    @names = names
  end

  # 定义一个方法 say_hi
  # 此方法没有参数，也不支持传入代码块
  def say_hi
    if @names.nil?
      puts "..."
    elsif @names.respond_to?("each")
      # respond_to 查询对象是否有某个方法，这里明显是在查看 names 对象是否含有 each 方法，若有的话就可以遍历了
      @names.each do |name|
        puts "Hello #{name}!"
      end
    else
      puts "Hello #{@names}"
    end
  end

  # 定义一个方法 say_bye
  def say_bye
    if @names.nil?
      puts "..."
    elsif @names.respond_to?("join")
      # 如果 names 是数组，有 join 方法，就合并数组为字符串
      puts "Goodbye #{names.join(", ")}. I will come back!"
    else
      puts "Goodbye #{@names}. I will come back!"
    end
  end

end

puts "start.."

# 打印文件名
puts __FILE__
puts $0

# 打印命令行入参
puts 'ARGV'
puts ARGV

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

puts "end.."
