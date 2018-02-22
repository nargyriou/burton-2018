local function parser(fd)
	local data = {}
	while true do
		local txtline = fd:read("*l)
		local row = {}
		for c in ("."):gmatch(txtline) do
			table.insert(row, c)
		end
		table.insert(data, row)
	end
end
return parser
