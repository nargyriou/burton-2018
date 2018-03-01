local function parser(fd)
	local firstline = fd:read("*l")
	local R,C,F,N,B,T = string.match(firstline, "([0-9]+) ([0-9]+) ([0-9]+) ([0-9]+) ([0-9]+) ([0-9]+)")
	R,C,F,N,B,T = tonumber(R), tonumber(C), tonumber(F), tonumber(N), tonumber(B), tonumber(T)
	
	assert(type(R) == "number", "R is invalid") -- number of rows of the grid ( 1 ≤ R ≤ 10 000)
	assert(type(C) == "number", "C is invalid") -- number of columns of the grid ( 1 ≤ C ≤ 10 000)
	assert(type(F) == "number", "F is invalid") -- number of vehicles in the fleet ( 1 ≤ F ≤ 1 000)
	assert(type(N) == "number", "N is invalid") -- number of rides ( 1 ≤ N ≤ 10 000)
	assert(type(B) == "number", "B is invalid") -- per-ride bonus for starting the ride on time ( 1 ≤ B ≤ 10 000)
	assert(type(T) == "number", "T is invalid") -- number of steps in the simulation ( 1 ≤ T ≤ 10^9 )

	local data = {}
	while true do
		local row = {}
		local txtline = fd:read("*l")

		if not txtline then break end

		for c in string.gmatch(txtline, " ?([0-9]+)") do
			table.insert(row, tonumber(c))
		end
		table.insert(data, row)
	end

	data.R = R
	data.C = C
	data.F = F
	data.N = N
	data.B = B
	data.T = T

	return data
end

-- local fd = io.open("datasets/b_should_be_easy.in", "r")
-- assert(fd)
-- local t = parser(fd)

-- print(require("tprint")(t, {inline=false}))

return parser
