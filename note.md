# 值
## 基本数据
1. 布尔值   `true` `false`
2. 数字     `1234`
3. 字符串   `"abc"`
4. 符号     `:abc`

## 数据结构
### 1. 数组
  - 声明            `arr = ["zero", 1, true]`   => `["zero", 1, true]`
  - 取值            `arr[0]`                    => `"zero"`
  - 增加            `arr.push(2, 3)`            => `["zero", 1, true, 2, 3]`
  - 从第n位到最后    `arr.drop(2) `              => `[true, 2, 3] # 返回新数组，不改变原数组`

### 2. 范围，最小值和最大值之间的集合
  - 声明            `ages = 10..28`             => `10..28`
  - 条目，转为数组    `ages.entries`              => `[10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28]`
  - 检验是否包含     `ages.inclue?(35)`          => `false`

### 3. 散列（hash），也就是常说的 map 类型，键值对列表
  - 声明            `fruits = { 'a' => 'apple', :b => 'banana', c: 'coconut' } # 注意使用符号作为键的两种方式`
  - 取值            `fruits['a']`                => `'apple'`
  - 取值2（符号）     `fruits[:b]`                => `'banana'`
  - 取值3（符号）     `fruits[:c]`                => `'coconut'`
  - 赋新值或修改      `fruits['l'] = 'lemon'`     => `'lemon'`

## 函数 proc ，可以理解为匿名函数，可以将其复制给一个变量以在其他位置调用
  - 声明            `-> x, y { x * y }`             => `#<Proc:0x000000013201df78@(irb):44 (lambda)>`，我猜这是一个地址
  - 复制给变量       `multiply = -> x, y { x * y }`  => `#<Proc:0x000000013200ce30@(irb):42 (lambda)>`，看，另一个地址？
  - 调用            `multiply.call(6, 9)`           => `54`
  - 调用2           `multiply[4, 3]`                => `12`


# 控制流，逻辑
### 1. if
``` ruby
if 2 < 3
  'less'
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
上面这段代码，可以学到以下几个点：
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
上面这段代码，可以学到以下几个点：
1. 定义对象的方法时，内部可以直接调用该对象上的其他方法，无需使用类似 `js` 中的 `this` 关键字，在 `ruby` 中，叫做 `self`。

``` rb
def multiply(x, y)
  x * y
end
multiply(2,3)
```
上面这段代码，可以学到以下几个点：
1. 如果没有在某一个具体的对象上定义方法，直接使用 `def` 关键字定义方法的话，相当于在 `main` 这个顶层对象上定义。这类似于 `js` 中的 `window` 或 `global` 对象，也能体现出 `ruby` 的面向对象的特性。


# 类和模块
## 类

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

### 并行赋值
``` ruby
a, b, c = [100, 200, 300]
```

### 模板字符串语法
``` ruby
'hello ruby'

w = 'world'
"Hello #{w}"
```
双引号中，支持使用 `#{表达式}` 来执行字符串插值的操作。

### 检查对象
``` ruby
o = Object.new
o
# => #<Object:0x000000013d22a248>

def o.inspect
  '[my object]'
end
o
# => [my object]
```
- 当检查一个对象时，会执行 `ruby` 对它检查方法的默认实现，即返回一个字符串地址；
- 但是可以重写该 `inspect` 方法，来自定义控制台的显示。也许可以对该对象增加一些描述

### 打印字符串
``` ruby
puts 'Hello world'
```
使用 `puts` 关键字来打印字符串，类似 `js` 的 `console.log()`

### 可变参数方法
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
也可以用作并行赋值

