
## chapter5 
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
