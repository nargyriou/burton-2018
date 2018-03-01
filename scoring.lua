--local parse = require('parser')
--local fd = io.open('datasets/a_example.in', 'r')
--local data = parse(fd)
local tprint = require('tprint')
local utils = require("utils")


local rides_score = {}


local function bonus_points(ride, bonus)
	if ride.start.step == ride.started_on then
		return bonus
	else
		return 0
	end
end

local function total()
	local total_of_points = 0

	for id_ride, ride  in ipairs( rides_score ) do
		total_of_points = total_of_points + ride.points
	end

	return total_of_points
end

local function scoring(data)
	for id_ride, ride  in ipairs( data ) do
		bonus_points(ride, data.B)
		if ride.started_on ~= nil then
			local ride_score = {
				id = id_ride,
				erliest_start = ride.start.step,
				start_at_step = ride.started_on,
				finish_at_step = ride.started_on + ride.cost,
				distance = ride.cost,
				bonus = bonus_points(ride),
				points = ride.cost + bonus_points(ride)
			}

			table.insert(rides_score, ride_score)
		end
	end

	print(tprint(rides_score, {inline=false}))
	print("Total score = ", total())

	--print(tprint(data, {inline=false}))

end

return scoring
