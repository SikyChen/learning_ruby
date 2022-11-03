# 值
## 基本数据
1. 布尔值   `true` `false`
2. 数字     `1234`
3. 字符串   `"abc"`
4. 符号     `:abc`

## 数据结构
### 1. 数组
``` ruby
arr = ["zero", 1, true]
# => ["zero", 1, true]

arr[0]
# => "zero"

arr.push(2, 3)
# => ["zero", 1, true, 2, 3]

# 从第 2 位到最后，返回新数组，不改变原数组
arr.drop(2)
# => [true, 2, 3]
```

### 2. 范围，最小值和最大值之间的集合
``` ruby
ages = 10..28
# => 10..21

# 转为数组
ages.entries
# => [10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21]

ages.inclue?(35)
# => false
```

### 3. 散列（hash），也就是常说的 map 类型，键值对列表
``` ruby
fruits = { 'a' => 'apple', :b => 'banana', c: 'coconut' }
# => { 'a' => 'apple', :b => 'banana', c: 'coconut' }

fruits['a']
# => 'apple'

fruits[:b]
# => 'banana'

fruits[:c]
# => 'coconut'

fruits['l'] = 'lemon'
# => 'lemon'
```
1. 声明时，可以使用字符串作为 key ，也可使用符号，注意 `:b =>` 和 `c:` 两种使用符号作为键名的方式
2. 给已有散列赋新值或者修改值，类似 `js` 的用法

## 函数 proc ，可以理解为匿名函数，可以将其复制给一个变量以在其他位置调用
``` ruby
multiply = -> x, y {
  x * y
}
# => #<Proc:0x000000013200ce30@(irb):42 (lambda)>

multiply.call(6, 9)
# => 54

multiply[7, 8]
# => 56
```
1. 声明并赋值给变量
2. 两种调用方式


# 控制流，逻辑
### 1. if
``` ruby
if 2 < 3
  'less'
elsif 2 == 3
  'equal'
else
  'more'
end

# => "less"
```

### case when
``` ruby
num = 2

case num
  when 1
    'one'
  when 2
    'two'
  else
    'more'
end

# => "two"
```

### 1. while
``` ruby
x = 1
# => 1

while x < 5
  x = x + 1
end
# => nil

x
# => 5
```

# 对象和方法

``` rb
o = Object.new
def o.add(x, y)
  x + y
end
o.add(1,2)
```
1. 声明一个空对象，使用 `Object.new` 的方法
2. 给对象定义一个方法的属性，使用 `def` 关键字
3. 方法的最后一行的表达式的值，自动作为方法的返回值，故可省略写 return
4. 调用对象上的方法时，跟 js 类似

``` rb
def o.add_twice(x, y)
  add(add(x, y), add(x, y))
end
o.add(2,3)
```
1. 定义对象的方法时，内部可以直接调用该对象上的其他方法，无需使用类似 `js` 中的 `this` 关键字，在 `ruby` 中，叫做 `self`。

``` rb
def puts_hello()
  puts 'hello world'
end
puts_hello
```
1. 如果没有在某一个具体的对象上定义方法，直接使用 `def` 关键字定义方法的话，相当于在 `main` 这个顶层对象上定义。这类似于 `js` 中的 `window` 或 `global` 对象，也能体现出 `ruby` 的面向对象的特性
2. 若方法无需参数，则声明方法及调用方法时，括号都可以省略不写


# 类和模块
## 类
### 1. 类的声明
``` ruby
class Calculator
  def initialize(name = "Ruby")
    puts "Hello " + name
  end

  def divide(x, y)
    x / y
  end
end

c = Calculator.new('Siky')
# => Hello Siky

c.divide(6, 2)
# => 3

c.class
# => Calculator
```
1. 定义一个类，类里面可以直接定义方法
2. 通过类上的 `new` 方法实例化出一个对象，方法会挂载在该对象上
3. 若类中定义了 `initialize` 方法，则会作为初始化方法在 `new` 的时候调用，参入就是 `new` 时的参数
3. 可以看到，实例化后的 c 其实就是一个对象，还可以通过上一节的方式，给 c 这个对象上定义新的方法，直接使用 `def c.add(x, y)` 即可
4. 可以通过 `c.class` 这样的方法获取对象所属的类

### 2. 类的继承
``` ruby
class BinaryCalculator < Calculator
  def divide(x, y)
    res = super(x, y)
    res.to_s(2)
  end

  def multiply(x, y)
    x * y
  end

  def divide2(x, y)
    divide(x, y)
  end
end

BinaryCalculator.superclass
# => Calculator
```
1. 通过使用 `<` 来进行继承
2. 通过使用 `.superclass` 获取超类
3. 在子类的方法中，使用 `super(x)` 直接调用父类的同名方法
4. 在子类的方法中，可以直接调用类下的其他方法

### 3. 类的属性
``` ruby
class Attrs
  attr_accessor :a
  attr_accessor :b
  :c

  def initialize()
    @a = 'aa'
    @c = 'cc'
  end

  def get_c
    @c
  end

  def set_c(c)
    @c = c
  end
end
# => :initialize

at = Attrs.new

at.a
# => "aa"
at.b
# => nil
at.b = 2
# => 2
at.b
# => 2

at.c
# NoMethodError undefined method `c' for Attrs
at.get_c
# => "cc"
a.set_c('CCC')
# => "CCC"
a.get_c
# => "CCC"
```
1. 在 `ruby` 中，类成员变量通过 `:变量名` 来声明，默认是私有的，例如 `c` ，无法在实例对象上直接访问
2. 通过关键字 `attr_accessor :a` 可以给类声明可读写的变量，例如 `a` 和 `b`

## 模块

``` ruby
module Addition
  def add(x, y)
    x + y
  end
end

class AddingCalculator < Calculator
  include Addition
end

ac = AddingCalculator.new

ac.add(1,2)
# => 3
ac.divide(6,2)
# => 3
```
1. 通过 `module` 关键字声明模块，模块内部定义方法跟类一样
2. 在定义类的使用，使用 `include` 关键字引入模块，这样该类中就会包含模块的方法


# 其它特性

### 1. 并行赋值
``` ruby
a, b, c = [100, 200, 300]
```

### 2. 模板字符串语法
``` ruby
'hello ruby'

w = 'world'
"Hello #{w}"
```
- 双引号中，支持使用 `#{表达式}` 来执行字符串插值的操作。

### 3. 检查对象
``` ruby
o = Object.new
o
# => #<Object:0x000000013d22a248>

def o.inspect
  '[my object]'
end
o
# => [my object]

def o.inspect
  self
end
o
```
1. 当检查一个对象时，会执行 `ruby` 对它检查方法的默认实现，即返回一个字符串地址；
2. 但是可以重写该 `inspect` 方法，来自定义控制台的显示
3. 当在 `inspect` 中使用 `self` 时，会通过 `to_s` 转为字符串进行控制台输出

### 4. 打印字符串
``` ruby
puts 'Hello world'
```
- 使用 `puts` 关键字来打印字符串，类似 `js` 的 `console.log()`

### 5. 可变参数方法
``` ruby
def putsArguments(*arg)
  arg
end

putsArguments(1,2,3,4)
# => [1, 2, 3, 4]
```
1. 类似 `js` 中函数的 `rest` 参数，即 `(a, ...b, c)` 参数
2. 在方法中使用时，就可以当做数组使用了

``` ruby
a, *b, c = [1, 2, 3, 4, 5]
a
# => 1
b
# => [2, 3, 4]
c
# => 5
```
3. 也可以用作并行赋值

### 6. 代码块 block
``` ruby
def do_three_times(str)
  yield(1)
  yield(2)
  yield(str)
end

do_three_times(6) { |n| puts "number: #{n}" }
number: 1
number: 2
number: 6
# => nil
```
1. 定义方法时，在方法内部使用 `yield` 关键字，表明该位置会调用传入的代码块，括号内可以传参数
2. 调用方法时，在入参括号的后面，通过使用 `{} 或 do end` 来定义需要被 `yield` 调用的代码块
3. 代码块中 `|n|` 是参数定义，后面跟具体的表达式即可，若无参数可省略不写

``` ruby
def has_block
  if block_given?
    yield
  else
    'No block'
  end
end

has_block
# => "No block"

has_block { 'Had block' }
# => "Had block"
```
4. 可以在方法中通过 `block_given?` 来判断是否有代码块传入

### 7. 枚举类型
在 Ruby 中枚举类型是指包含了 `Enumberable` 内置模块的类，可以简单的理解为那些可以被遍历的类型。如：数组、范围、散列表。
``` ruby
(1..10).count { |n| n.even? }
# => 5
```
1. `count` 方法就是一个计数方法，相当于遍历了 `1..10` 的范围，每遍历到一个元素计数一次，故 `(1..10).count == 10`
2. `count` 方法可以接受一个代码块，当代码块的返回值为 `true` 时，才进行计数。故上方代码意思是只有偶数才计数一次，所以结果是 `5` 。

``` ruby
(1..10).select { |n| n.odd? }
# => [1, 3, 5, 7, 9]
```
1. 类似 `js` 中的 `Array.filter` 方法
2. `select` 方法是个过滤方法。此处是过滤所有奇数，返回新的数组。

``` ruby
(1..10).any? { |n| n == 11 }
# => false

(1..10).any? do |n|
  puts n
  n == 2 
end
# 1
# 2
# => true
```
1. 类似 `js` 中的 `Array.some` 方法
2. `any` 方法是判断数据中是否有符合代码块条件的元素，如果有的话就返回 `true` ，否则返回 `false`
3. `any` 方法在遍历过程中，当遇到第一个符合代码块条件的元素后，就直接返回 `true` 了，不会再继续遍历后面的元素
4. `Ruby` 中的一些内置方法，如果是返回 `Boolean` 值的，会以 `?` 结尾，应该是为了更好的语义化

``` ruby
(1..10).all? { |n| n < 8 }
# => false
```
1. 类似 `js` 中的 `Array.every` 方法
2. `all` 方法是判断数据中是否所有元素都符合代码块的条件，若是则返回 `true` ，否则返回 `false`

``` ruby
(1..5).map { |n| n * 2 }
# => [2, 4, 6, 8, 10]
```
1. 类似 `js` 中的 `Array.map` 方法
2. `map` 方法对数据中的所有元素执行代码块中的方法，并将代码块的返回值写入一个新的数组中，最终返回新的数组

``` ruby
(1..5).each do |n|
  if (n.even?)
    puts 'is even'
  else
    puts 'is odd'
  end
  n = n * 2
end
# is odd
# is even
# is odd
# is even
# is odd
# => 1..5
```
1. 类似 `js` 中的 `Array.forEach` 方法
2. `each` 方法对数据中的所有元素执行代码块中的方法，不会改变原数组，也不会产生新数组

``` ruby
(1..6).select { |n| n.even? }
# => [2, 4, 6]

(1..6).select(&:even?)
# => [2, 4, 6]
```
1. 如果代码块只有一个参数，且该参数只调用一个无需入参的消息(方法)，那么可以缩写为 `&:message`
- ps: 不得不说 `ruby` 的编译器好痛苦啊，这种语法糖也支持😂

``` ruby
[[1,2,3], [4,5,6]].flat_map { |arr| arr }
#  => [1, 2, 3, 4, 5, 6]
```
1. 抹平一个数组
2. 通过代码块可以看出，`flat_map` 是接受到每一个数组元素后，打散 `push` 进结果数组中，所以需要代码块中的返回值，必须是数组才行

``` ruby
(1..10).inject(2) { |result, number| result + number }
#  => 57

(1..3).inject({}) do |result, number|
  result[number.to_s] = number
  result
end
# => {"1"=>1, "2"=>2, "3"=>3}
```
1. 类似 `js` 中的 `Array.reduce` 方法
2. `inject` 的入参，即使结果 `result` 的初始值
3. 每次遍历到一个元素，执行代码块中的方法，参数 `result` 代表到当前为止的结果， `number` (第二个参数)代表遍历到的当前值
4. 最终返回 `result` 的值

### 8. 结构体
``` ruby
AStruct = Struct.new(:x, :y)

class Point < AStruct
  def puts_xy
    puts x
    puts y
  end
end

p = Point.new(2, 3)

p.puts_xy
# 2
# 3
# => nil

p.x
# => 2
p.y
# => 3
```
1. 可以看到，结构体作为类的超类使用
2. 结构体在 `new` 的时候传入的属性，会作为子类实例的属性，能够读写
3. 尽管在类中，使用 attr_accessor 关键字定义属性也是可以读写的，但是使用结构体看起来更加方便

### 9. 给内置对象扩展方法（Monkey Patching）
``` ruby
class Monkey
  def say
    "Wu wu wu ~"
  end
end

m = Monkey.new

m.say
# => "Wu wu wu ~"

# 直接复写 Monkey 类给它增加新的方法
class Monkey
  def climb
    "Climbing tree!"
  end
end

m.say
# => "Wu wu wu ~"
m.climb
# => "Climbing tree!"
```
1. 重新定义同名的类时，其实是给原类做扩展（修改和新增）
2. 类的实例（包括新的和已经创建的实例），都会享受到新的扩展

``` ruby
"hello ruby".shout
# NoMethodError (undefined method `shout' for "hello ruby":String)

class String
  def shout
    upcase + '!!!'
    # 同
    # self.upcase + '!!!'
  end
end

"hello ruby".shout
# => "HELLO RUBY!!!"
```
1. 内置对象也是可以进行扩展的
2. `"hello ruby"` 字符串作为 `String` 类的实例，当 `shout` 内部调用 `upcase` 方法时可以直接使用，类似 `self.upcase`

### 10. 常量
``` ruby
NUMBERS = [1, 2, 3, 4]
# => [1, 2, 3, 4]

NUMBERS = [2]
# (irb):115: warning: already initialized constant NUMBERS
# (irb):114: warning: previous definition of NUMBERS was here
# => [2]

NUMBERS
# => [2]

# -------------------

class Greetings
  ENGLISH = 'hello'
  CHINESE = '你好'

  def get_greetings
    puts ENGLISH
  end
end
# => '你好'

Greetings::CHINESE
# => "你好"

gs = Greetings.new
gs.get_greetings
# hello
```
1. 以大写开头的变量会被认为是常量，当修改常量的值时，会有警告，但会修改成功
2. 类和模块也总是以大写开头，所以也是常量
3. 类中定义和访问常量的方法如上

### 11. 删除常量
``` ruby
NUMBERS
# => [2]

Object.send(:remove_const, :NUMBERS)
# => [2]

NUMBERS
# NameError (uninitialized constant NUMBERS)

Greetings::ENGLISH
# => "hello"

Greetings.send(:remove_const, :ENGLISH)
# => "hello"

Greetings::ENGLISH
# NameError (uninitialized constant Greetings::ENGLISH)
```
1. 给常量所在的对象通过 `send` 方法发送一个名为 `:remove_const` 的消息，并将常量名作为符号对象传进去，可以删除该常量
2. 由于 `:remove_const` 是对象的私有方法，所以只能通过 `send` 调用，而不能使用 `Object.remove_const(:常量名)`
