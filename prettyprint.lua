-- 
-- 
-- 
-- ╬
-- 
-- 
-- 

local parse = require "parser"
local tprint = require "tprint"

local function prettyprint(data)
							 -- local cellSize = math.log(data.F) + 1
	local blankCell = " "    -- string.rep(".", cellSize)
	local startingCell = "S" -- string.rep("S", cellSize)
	local finishCell = "F"   -- string.rep("F", cellSize)
	local matrix = {}

	-- init
	for row=1, data.R do
		matrix[row] = {}
		for column=1, data.C do
			matrix[row][column] = blankCell
		end
	end



	-- Dessin
	for rideNumber,v in ipairs(data) do
		assert(v.start and v.finish)

		local sr, fr
		sr = math.min(v.start.row, v.finish.row)
		fr = math.max(v.start.row, v.finish.row)
		for i=sr, fr do
			matrix[i][sc] = rideNumber%10
		end

		local sc, fc
		sc = math.min(v.start.col, v.finish.col)
		fc = math.max(v.start.col, v.finish.col)
		for j=sc, fc do
			matrix[sr][j] = rideNumber%10
		end

		matrix[v.start.row][v.start.col] = startingCell
		matrix[v.finish.row][v.finish.col] = finishCell
	end


	-- Printing
	for row=1, data.R do
		local str = "" --loop indépendant pour luajit
		for column=1, data.C do
			str = str .. matrix[row][column]
		end
		print(str)
	end

	return ""
end

-- local fd = io.open("datasets/b_should_be_easy.in", "r")
-- local data = parse(fd)
-- -- --print(tprint(data, {inline=false}))
-- local buff = prettyprint(data)

return prettyprint

-- 		─	━	│	┃	┄	┅	┆	┇	┈	┉	┊	┋	┌	┍	┎	┏
-- 		┐	┑	┒	┓	└	┕	┖	┗	┘	┙	┚	┛	├	┝	┞	┟
-- 		┠	┡	┢	┣	┤	┥	┦	┧	┨	┩	┪	┫	┬	┭	┮	┯
-- 		┰	┱	┲	┳	┴	┵	┶	┷	┸	┹	┺	┻	┼	┽	┾	┿
-- 		╀	╁	╂	╃	╄	╅	╆	╇	╈	╉	╊	╋	╌	╍	╎	╏
-- 		═	║	╒	╓	╔	╕	╖	╗	╘	╙	╚	╛	╜	╝	╞	╟
-- 		╠	╡	╢	╣	╤	╥	╦	╧	╨	╩	╪	╫	╬	╭	╮	╯
-- 		╰	╱	╲	╳	╴	╵	╶	╷	╸	╹	╺	╻	╼	╽	╾	╿
-- 		
