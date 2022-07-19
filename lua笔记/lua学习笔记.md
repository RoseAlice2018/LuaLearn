
## chapter3 数值

### 3.1 整型算术回环
- 当整数型操作时出现比MIN，MAX溢出时，结果就会回环（wrap  around）
```lua
> math.maxinteger + 1 == math.mininteger -->true
> math.mininteger - 1 == math.maxinteger -->true
> -math.mininteger == math.maxinteger + 1 == math.mininteger
> math.mininteger // -1 == math.mininteger 
```
### 3.2 负数的%操作
- X%K
- 如果K是正常量，即使X是负数，结果也会在【0，K-1】之间。
- % 取模运算对的结果符号永远跟随第二个常量的符号。
### 3.3 运算符操作优先级
优先级从高到底
```lua
^
- # ~ not 
* / // %
..
<< >>
& 
~
|
< > <= >= ~= ==
and 
or
```
### 3.4 三角函数

### 3.5 正态分布的伪随机数发生器

### 3.6 新的运算符 //
- // floor除法，floor除法将会对得到的商向负无穷取整。从而保证结果是一个整数。
```lua
> 3 // 2 --> 1
> -9 // 2 -->-5
```

### 3.7 floor , ceil , modf
- floor 向负无穷取整
- ceil  向正无穷取整
- modf  向零取整

## chapter4 字符串
### 4.1 gsub 函数
- string.gsub(s,pattern,replace[,m])
- 函数在string s中，按pattern给的格式寻找，并用replace进行代替，如果有m（这个变量可选），则只replace查找找的前m个子串
- gsub都使用很多，可以参考chapter4 gsub文件学习。

### 4.2  [[]] 使用
- 可以使用一对[[]]来声明长字符串或多行字符串常量
  - 被扩起来的内容中的转义序列不会被转义。
  - 如果多行字符串的第一个字符是换行符，那么这个换行符会被忽略。

```lua
page = [[
   <html>
   <head>
   </head>
   </html>
]]
```
### 4.3  utf8
可以使用转义序列\u{h..h}来声明UTF-8字符，{}中支持任意有效的十六进制
```lua
> \u{3b1} \u{3b2} \u{3b3} ---> 
```
### 4.4 and or not
### 4.4 #操作符
- 可以使用#操作符获得字符串长度
```lua
a = "hello"
print(#a)
```
## chapter5 表 
### 5.1 a.x == a["X"] a[x] == a[x]
- 注意两者之间差别

```
sunday = "Monday"
monday = "Sunday"
t = {sunday = "Monday",[sunday] = monday }
--- t["sunday"] = "Monday", t["Moday"] = "Sunday"
print(t.sunday,t[sunday],t[t.sunday])
```

### 5.2 列表和序列
table 中的 元素 按 [1...n]排列，没有nil字段的空洞，或是其他key，则称之为序列。

### 5.3 遍历表
pairs迭代器遍历，元素出现的顺序随机，但是保证每个元素仅仅出现一次。
ipairs迭代器遍历，lua保证元素顺序出现。
```lua
t = {10,"hello",100,"world"}
for k,v in pairs(t) do
    print(k,v)
end

for k,v in ipairs(t) do
    print(k,v)
end
```

### 5.4 lua的安全访问

比如在访问 lib.foo 函数时，如果第一个lib就不存在，会造成程序出错。
lua可以如下实现安全访问，
假设我们想要访问 company.director.address.zipcode

```lua
zip = (((company or {}).director or {}).address or {}).zipcode
```

### 5.5 remove函数 和 insert 函数用法
- table.insert 可以向序列指定的位置插入一个元素，其他元素依次后移。如果不指定位置，则在序列的最后插入元素，并且不移动任何位置。
- table.remove 删除并返回序列指定位置的元素，然后将其后的元素向前移动填充删除元素后造成的空洞。如果不指定位置，将会删除序列的最后一个元素。


因为对于a or {} ,当a 为nil时返回{},不会造成错误。


## chapter 6
### 6.1 函数返回值多重赋值注意点
- 注意只有当返回值处于一系列表达式最末尾或者唯一的时候才能返回多值结果。如果不是的话只能返回一个结果。
```lua
function foo() return "a","b"  end

x = foo()  -- x = "a"
x,y = foo() -- x = "a", y = "b"
x,y,z = foo() -- x = "a", y = "b", z = nil
x,y = foo(),20 -- x = "a", y = "20"


```
- 当一个函数进行这样操作，也就是用一个函数，比如print，来调用foo函数的时候。
  - 当foo为最后一个或者唯一函数的时候，第一个函数foo的所有返回值都会变成print的参数
  - 如果foo不是，lua会把其返回值的个数调整为1。
  - f(foo())lua将会把foo的返回值个数调整到跟f的参数列表个数一致。

### 6.2 请编写一个函数，该函数用于打乱一个指定的数组。请保证所有的排列都是等概率的。


## chapter8 补充
### 8.1 在Lua中，循环体内的声明变量的作用域包括测试条件
```lua
local sqr = x / 2
repeat
  sqr = (sqr + x/sqr) / 2
  local error = math.abs(sqr^2 - x)
until error < x/10000 --局部变量'error'此时仍然可见
```
