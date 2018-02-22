local parser = require "parser"
local fd = io.stdin
local firstline = fd:read("*l")
local matrix = parser(fd)

local function levelchanged(lvl, cfg)
	if lvl==1 then
		cfg.inline=true
		cfg.indent=""
		cfg.list_sep=''
	else
		cfg.inline=false
		cfg.indent=""
		cfg.list_sep=','
	end
	return cfg
end
local function dump(matrix)
	local tprint=require"tprint"
	return tprint(matrix, {
		levelchanged=levelchanged,
	})
end
local function dumptofile(matrix,file)
	local tprint=require"tprint"
	local fd = io.open(file,"w")
	fd:write("return "..tprint(matrix, {inline=true}))
end
--dumptofile(matrix,"data1.lua")
print(dump(matrix))

