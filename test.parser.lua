local parser = require "parser"
local fd = io.stdin
local firstline = fd:read("*l")
local map = {["T"]=1, ["M"]=2 } -- map the value

local matrix = parser(fd,map)

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
print(dump(matrix))

