local function printRect(width, height)
	for i=1, height do
		print(string.rep("#", width))
	end
	print(" ")
end

local function bruteforme(cellno)
	for width = 1, cellno do
		local maxHeight = math.floor(cellno/width)
		local minHeight = 1

		for height = minHeight, maxHeight do
			printRect(width, height)
		end
	end
end

return bruteforme