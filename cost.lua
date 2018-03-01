local rides = require"parser"(io.stdin)
local utils = require"utils"

local function wait(a,b)
	return a.finish.step - b.dealine
end

local function ride_compare(ride1,ride2)
	if ride1==ride2 then return nil end
	local dcost = utils.diff(ride1.start, ride2.finish) -- cout en distance
	if ride1.finish.step + dcost > ride2.deadline then return nil end -- pas possible
	local tcost = ride2.start.step - ride1.finish.step -- 
	local timewaste = math.max(dcost,tcost) -- le coup final est le delai max ou la distance max
	local bonus = dcost <= tcost
	return timewaste, bonus
end

	-- local tcost = wait(ride1.start, ride2.finish) -- cout en attente

for i,ride in ipairs(rides) do
	--print(ride.id, ride.start.step, ride.cost, ride.deadline)
	for i2, ride2 in ipairs(rides) do
		ride_compare(ride, ride2)
		--
	end
end
