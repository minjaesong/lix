---
--- This is a filesystem API for generic purpose (e.g. Windows, Linux)
--- For virtualised environment, they must provide compatible API themselves and/or
---   install compatibility module under /etc
--- 
--- The purpose of this API is to route Lix's API call to system compatible ones, and deal with
---   the pwd of the parent operation system.
---
--- Created by torvald.
--- DateTime: 2020-03-09 07:22
---


if not pcall(function() 
    local lfs = require("lfs")
end) then
    LIX_MSG_INSTALL_PACKAGE("luafilesystem")
end


if not _G.fs then _G.fs = {} end

--- the real pwd of current operation system (Windows or Linux)
--- for virtualised environment (e.g. OpenComputers mod for Minecraft), this
---   field must be kept as an '/'.
local realpwd = lfs.currentdir() .. "/"
local function resolve(path)
    return realpwd .. path
end


fs.list = function(path)
    return lfs.dir(resolve(path))
end

fs.isDirectory = function(path)
    return lfs.attributes(resolve(path), "mode") == "directory"
end

fs.open = function(path, mode)
    return io.open(resolve(path), mode)
end

fs.open = function(path)
    return fs.open(path, "r")
end

fs.copy = function(from, to)
end

fs.rename = function(old, new)
    return os.rename(resolve(old), resolve(new))
end

fs.remove = function(path)
    for file in lfs.dir(resolve(path)) do
        if file ~= "." and file ~= ".." then
            if lfs.attributes(file,"mode") == "file" then os.remove(file)
            elseif lfs.attributes(file,"mode") == "directory" then
                for l in lfs.dir(resolve(path.."/"..file) do
                     os.remove(l)
                end
                os.remove(file)
            end
        end
    end
end