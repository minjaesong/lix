---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by torvald.
--- DateTime: 2019-11-03 22:00
---

local args = {...}
local dir = args[1] or env.PWD

--print("args-1",args[1])

-- resolve relative dir
if args[1] and args[1]:byte(1) ~= 0x2F and args[1]:byte(1) ~= 0x5C then
    dir = env.PWD .. args[1]
end

--print("lsdir", dir)
--print("realdir", realdir)

for name, _ in fs.list(dir) do
    if fs.isDirectory(dir .. "/" .. name) then
        print(name .. "/")
    else
        print(name)
    end
end