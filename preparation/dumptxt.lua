local function totext(matrix)
	local r={}
	for _i, line in ipairs(matrix) do
		table.insert(r, table.concat(line,""))
	end
	return table.concat(r,"\n")
end
return totext
