local parse = require('parser')
local fd = io.open('datasets/a_example.in', 'r')
local data = parse(fd)
local tprint = require('tprint')

local total_of_points
local rides_score = {}

local function bonus_points(ride)
	if ride.start.step == 1 then--ride.started_on then
		return data.B
	else
		return 0
	end
end

for id_ride, ride  in ipairs( data ) do
	bonus_points(ride)
	--if ride.started_on ~= nil then
		local ride_score = {
			id = id_ride,
			erliest_start = ride.start.step,
			start_at_step = 1, --ride.started_on,
			finish_at_step = 1 + ride.cost, --ride.started_on + ride.cost,
			distance = ride.cost,
			bonus = bonus_points(ride),
			points = ride.cost + bonus_points(ride)
		}

		table.insert(rides_score, ride_score)
	--end
end

print(tprint(rides_score, {inline=false}))

--local function scoring ()
--end

