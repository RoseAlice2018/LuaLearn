---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by reebdeve.
--- DateTime: 2022/7/17 17:32
---
--- exp1
--- 7.1
--- 请编写一个程序，该程序读取一个文本文件然后将每行的内容安装字母表顺序排序后重写该文件。
--- 如果调用时不带参数，则从标准输入读取并向标准输出写入。
--- 如果调用时传入一个文件名作为参数，则该文件读取并向标准输出写入。
--- 如果调用时传入两个文件名作为参数，则从第一个文件读取并将结果写入到第二个文件中。
--- exp 2
--- 7.2 改成7.1 的程序，使得当前指定的输出文件已经存在时，要求用户确认

local function file_exists(name)
    local f = io.open(name)
    if f then
        io.close(f)
        return true
    end
    return false
end


local function SortAndWrite(inputFile,outputFile)
    local function writeHelper(str)
        local t = {string.byte(str,1,-1)}
        table.sort(t)
        str = string.char(table.unpack(t))
        io.write(str,"\n")
    end
    local of = nil
    if outputFile then
        if file_exists(outputFile) then
            local signal = ""
            local fmt = string.format("File %s is already existed, do you still want to rewrite it?(yes/no)",outputFile)
            while(signal ~= "YES" and signal ~= "NO") do
                print(fmt)
                signal = string.upper(io.read())
            end
            if signal == "YES" then
                of = io.output(outputFile)
            end
        else
            of = io.output(outputFile)
        end
    end
    if inputFile then
        for line in io.lines(inputFile) do
            writeHelper(line)
        end
    else
        writeHelper(io.read())
    end
    if not of then
        print()
    end
end
    SortAndWrite("7_1_input.txt","7_1_output.txt")

--- 练习7.3
--- 对比使用下列几种不同的方式把标准输入流复制到标准输出流中的lua程序的性能表现
--- -按字节 -按行 -按块（每块大小8KB）-一次性读取整个文件
---

---  写入数据
function writedata()
    io.output("7_2_input.txt","w")
    for i = 1,100000 do
        str = string.rep("-",100)
        io.write(str)
        io.write("\n")
    end
end
--writedata()
local function formatCost(copyType,costTime)
    return copyType.."cost time : "..costTime.."s\n"
end
local function test7_3()
    assert(io.input("7_2_input.txt","r"))
    local str = io.read("a")
    local bytes = {string.byte(str)}
    local startTime =  nil

    -- byte by byte
    startTime = os.time()
    for i = 1, #bytes do
        io.write(bytes[i])
    end
    local cost1 = os.difftime(os.time(),startTime)

    -- line by line
    startTime = os.time()
    for lines in io.lines("7_2_input.txt") do
        io.write(lines)
    end
    local cost2 = os.difftime(os.time(),startTime)
    -- in chunks of 8kb
    startTime = os.time()
    for block in io.input():lines(2^13) do
        io.write(block)
    end
    local cost3 = os.difftime(os.time(),startTime)

    -- whole file
    startTime = os.time()
    io.write(str)
    local cost4 = os.difftime(os.time(),startTime)
    print("\n==========Compare CostTime========\n")
    print(formatCost("byte by byte",cost1))
    print(formatCost("line by line",cost2))
    print(formatCost("in chunks of 8kb",cost3))
    print(formatCost("whole file",cost4))
end

-- test7_3()

--- exp4
--- 7.4
--- exp5
--- 7.5
--- 编写一个程序，使得其可以输出一个文本文件的最后n行。当文件较大时且可以使用seek时，尝试避免读取整个文件来完成。

local  function getfileSize(file)
    if not file then
        return 0
    end
    local current = file:seek()
    local size    = file:seek("end")
    file:seek("set",current)
    return size
end

local buffsize = 1024
local function print_nLastLine(n,filename)
    local file = io.open("filename","r")
    if not file then
        print(tostring(filename).." file dose not exist")
        return
    end
    n = n > 0 and n or 1
    local loopTime = 1
    local iFilesize = getfileSize(file)
    while true do
        local iCurSize = iFilesize - file:seek("end",math.max(-loopTime*buffsize,iFilesize))

    end
end
