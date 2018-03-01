local tprint = require('tprint')

local function diff(start, finish)
  return math.abs(start.col - finish.col) + math.abs(start.row - finish.row)
end

local function is_doable(ride, pos, step)
  local cost = diff(ride.start, pos)
  return (step + cost) > ride.deadline
end

local function take_ride(car, ride, current_step)
  local cost = diff(car.position, ride.start) + ride.cost
  car.position = ride.finish
  car.free = current_step + cost
  table.insert(car.rides, ride.id)
end

local function output(cars)
  for i, car in ipairs(cars) do
    local rides = table.concat(car.rides, " ")
    print(#car.rides .. " " .. rides)
  end
end

return {
  diff = diff,
  take_ride = take_ride,
  is_doable = is_doable,
  output = output,
}

-- vim:set noet sts=2 sw=2 ts=2:
