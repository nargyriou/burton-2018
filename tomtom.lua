local parser = require('parser')
local tprint = require('tprint')
local utils = require("utils")
local cost = require('cost')

local rides = parser(io.stdin)

-- local grid = {}
-- for y=1,rides.R do
--   local row = {}
--   for x=1,rides.C do
--     row[x] = {}
--   end
--   grid[y] = row
-- end

local cars = {}
for i=1,rides.F do
  table.insert(cars, {
    position = {
      row = 1,
      col = 1,
    },
    free = 1, -- when the car will be freed
    rides = {},
    last_ride = nil
  })
end

-- rides = cost.compute(rides)

function get_better(pos, current, next)
  if utils.is_doable(next, pos, 1) then
    if not current then return next end
    if utils.diff(pos, next.start) < utils.diff(pos, current.start) then
      return next
    else
      return current
    end
  else
    return current
  end
end

function get_next_car(current, next)
  if not current then return next end
  if current.free < next.free then
    return current
  else
    return next
  end
end

function update_next_car(current, cars)
  for _, car in ipairs(cars) do
    current = get_next_car(current, car)
  end
  return current
end

local next_car = nil
for i, car in ipairs(cars) do
  local first = nil
  for _, ride in ipairs(rides) do
    first = get_better(car.position, first, ride)
  end
  utils.take_ride(car, first, car.free)
  next_car = get_next_car(next_car, car)
end

while true do
  local seen_all = true

  for _, ride in ipairs(rides) do
    if utils.is_doable(ride, next_car.position, next_car.free) then
      utils.take_ride(next_car,ride, next_car.free)
      next_car = update_next_car(next_car, cars)
      seen_all = false
      break
    end
  end

  if seen_all then
    break
  end
end

-- utils.take_ride(cars[1], rides[1], current_step)
-- utils.take_ride(cars[2], rides[3], current_step)
-- utils.take_ride(cars[2], rides[2], current_step)

utils.output(cars)

-- vim:set noet sts=2 sw=2 ts=2:
