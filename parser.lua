local function parser(fd, map)
	local firstline = fd:read("*l")
	local R,C,L,H=string.match(firstline, "([0-9]+) ([0-9]+) ([0-9]+) ([0-9]+)")
	R,C,L,H = tonumber(R), tonumber(C), tonumber(L), tonumber(H)
	assert(type(R)=="number")
	assert(type(C)=="number")
	assert(type(L)=="number")
	assert(type(H)=="number")
	local data = {}
	while true do
		local txtline = fd:read("*l")
		if not txtline then break end
		local row = {}
		for c in txtline:gmatch("(.)") do
			if map and map[c] then
				c=map[c]
			end
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
return parser
