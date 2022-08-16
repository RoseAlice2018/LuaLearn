---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by reebdeve.
--- DateTime: 2022/7/20 16:26
---
 a = {p = print}
a.p("Hello World")
--- 函数匿名
network = {
 {name = "grauna", IP = "210.26.30.34"},
 {name = "arraial", IP = "210.26.30.23"},
 {name = "lua", IP = "210.26.23.12"},
 {name = "derain", IP = "210.26.23.20"},
}

table.sort(network,function(a, b) return (a.name > b.name) end)

--- derivative
function derivative(f,delta)
 delta = delta or 1e-4
 return function (x)
   return ((f(x+delta)-f(x))/delta)
 end
end

c = derivative(math.sin)
print(math.cos(5.2),c(5.2))

--- 9.2
Lib = {}
Lib.foo = function (x,y) return x+y end
Lib.goo = function (x,y) return x-y end

print(Lib.foo(2,3),Lib.goo(2,3))


Lib = {
 foo = function (x,y) return x + y end,
 goo = function (x,y) return x - y end
}

Lib = {}
function Lib.foo (x,y) return x + y end
function Lib.goo (x,y) return x - y end


