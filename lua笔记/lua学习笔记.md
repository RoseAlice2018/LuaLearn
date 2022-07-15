
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

因为对于a or {} ,当a 为nil时返回{},不会造成错误。


