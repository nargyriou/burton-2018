local function printRect(width, height)
	for i=1, height do
		print(string.rep("#", width))
	end
end

local function bruteforme(cellno)
	local results = {}

	for width = 1, cellno do
		local maxHeight = math.floor(cellno/width)
		local minHeight = 1
		
		--if width*minHeight == 1 then
		if width == 1 then
			minHeight = 2
		end

		for height = minHeight, maxHeight do
			table.insert(results, {width, height} )
		end
	end

	return results
end

-- local res = bruteforme(9)
-- for i,v in pairs(res) do
-- 	printRect(v[1], v[2])
-- 	print("")
-- end

return bruteforme