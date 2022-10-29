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