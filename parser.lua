local function parser(fd, map)
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
	return data
end
return parser
