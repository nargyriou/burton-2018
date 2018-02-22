local parser = require "parser"
local fd = io.stdin

local mapvalues = require "mapvalues"

local matrix = parser(fd,mapvalues)

local function levelchanged(lvl, cfg)
	if lvl==1 then
		cfg.inline=true
		cfg.indent=""
	else
		cfg.inline=false
		cfg.indent=""
	end
	return cfg
end
local function dump(matrix)
	local tprint=require"tprint"
	return tprint(matrix, {
		levelchanged=levelchanged,
	})
end
print("return "..dump(matrix))

