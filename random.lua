local parse = require "parser"
local tprint = require "tprint"
local socket = require "socket"
local utils = require "utils"

local function bullshit(data)
	local vehicles = {}
	-- init les vehicules
	for i=1, data.F do
		vehicles[i] = {rides = {}}
		vehicles[i].n = 0
		vehicles[i].step = 0
	end

	-- pour tous les rides
	for i=1, data.N do
		-- vehicule au hasard
		local tries = 0
		while tries < 10000 do
			local v = vehicles[math.random(1, data.F)]
			local ride = data[i]

			-- print(tprint(ride, {inline=false}))

			if v.step + ride.cost < ride.deadline then
				-- on lui ajoute le ride i
				table.insert(v.rides, {ride, start=v.step})
				v.n = v.n+1
				v.step = v.step + ride.cost
				ride.started_on = v.step
				print("Ride " .. i .. " done")
				break
			end
			tries = tries + 1
		end
	end

	return vehicles
end

local seed = math.floor(   (socket.gettime()*10000) % 5000 )
math.randomseed(seed)
local fd = io.open("datasets/b_should_be_easy.in", "r")
local data = parse(fd)
--print(tprint(data, {inline=false}))
local t = bullshit(data)

print(tprint(data, {inline=false}))




return bullshit