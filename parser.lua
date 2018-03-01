local function parser(fd)
	local firstline = fd:read("*l")
	local R,C,F,N,B,T = string.match(firstline, "([0-9]+) ([0-9]+) ([0-9]+) ([0-9]+) ([0-9]+) ([0-9]+)")
	R,C,F,N,B,T = tonumber(R), tonumber(C), tonumber(F), tonumber(N), tonumber(B), tonumber(T)
	
	assert(type(R) == "number", "R is invalid")
	assert(type(C) == "number", "C is invalid")
	assert(type(F) == "number", "F is invalid")
	assert(type(N) == "number", "N is invalid")
	assert(type(B) == "number", "B is invalid")
	assert(type(T) == "number", "T is invalid")

	local data = {}
	while true do
		local row = {}
		local txtline = fd:read("*l")

		if not txtline then break end

		for c in string.gmatch(txtline, " ?([0-9]+)") do
			table.insert(row, c)
		end
		table.insert(data, row)
	end
	data.R=R
	data.C=C
	data.L=L
	data.H=H
	return data
end

local fd = io.open("datasets/b_should_be_easy.in", "r")
assert(fd)
local t = parser(fd)

print(require("tprint")(t, {inline=false}))

return parser
