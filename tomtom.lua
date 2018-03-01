local parser = require('parser')
local tprint = require('tprint')
local utils = require("utils")

local rides = parser(io.stdin)

local grid = {}
for y=1,rides.R do
  local row = {}
  for x=1,rides.C do
    row[x] = {}
  end
  grid[y] = row
end

local current_step = 1

local cars = {}
for i=1,rides.F do
  table.insert(cars, {
    position = {
      row = 1,
      col = 1,
    },
    free = 1, -- when the car will be freed
    rides = {}
  })
end

utils.take_ride(cars[1], rides[1], current_step)
utils.take_ride(cars[2], rides[3], current_step)
utils.take_ride(cars[2], rides[2], current_step)

utils.output(cars)

-- vim:set noet sts=2 sw=2 ts=2:
