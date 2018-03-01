local tprint = require('tprint')

local function diff(start, finish)
  return math.abs(start.col - finish.col) + math.abs(start.row - finish.row)
end

local function is_doable(ride, pos, step)
  if ride.started_on then return false end
  local cost = diff(ride.start, pos)
  return (step + cost) < ride.deadline
end

local function take_ride(car, ride, current_step)
  local pre_cost = diff(car.position, ride.start)
  local cost = pre_cost + ride.cost
  car.position = ride.finish
  car.free = current_step + cost
  table.insert(car.rides, ride.id)
  ride.started_on = current_step + pre_cost
  car.last_ride = ride
end

local function output(cars)
  for i, car in ipairs(cars) do
    local rides = table.concat(car.rides, " ")
    print(#car.rides .. " " .. rides)
  end
end

local function best_car(cars, ride, current_step)
  local available = {}
  for i, car in ipairs(cars) do
    local cost = diff(car.position, ride.start.position)
    if car.free + cost < ride.deadline then
      table.insert(available, {
        cost = cost,
        car = car
      })
    end
  end

  table.sort(available, function(a, b) return a.cost < b.cost end)

  return available
end

return {
  diff = diff,
  take_ride = take_ride,
  is_doable = is_doable,
  output = output,
}

-- vim:set noet sts=2 sw=2 ts=2:
