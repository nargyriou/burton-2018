local tprint = require"tprint"
local utils = require"utils"

local function wait(a,b)
  return a.finish.step - b.dealine
end

local function ride_compare(ride1, ride2)
  if ride1==ride2 then return nil end
  local dcost = utils.diff(ride1.start, ride2.finish) -- cout en distance
  if ride1.start.step + ride1.cost > ride2.deadline then return nil end
  local risky = ride1.finish.step + dcost > ride2.deadline -- pas possible si finish
  local tcost = ride2.start.step - ride1.finish.step --
  local timewaste = math.max(dcost,tcost) -- le coup final est le delai max ou la distance max
  local bonus = dcost <= tcost
  return timewaste, bonus, risky
end

-- local tcost = wait(ride1.start, ride2.finish) -- cout en attente

local function compute(rides)
  for i,ride in ipairs(rides) do
    ride.connections = {
      incoming = {},
      outgoing = {}
    }
  end

  for i,ride in ipairs(rides) do
    --print(ride.id, ride.start.step, ride.cost, ride.deadline)
    for i2, ride2 in ipairs(rides) do
      local timewaste, bonus, risky = ride_compare(ride, ride2)
      if timewaste then
        table.insert(ride.connections.outgoing, {
          ride = ride2,
          timewaste = timewaste,
          bonus = bonus,
          risky = risky
        })

        table.insert(ride2.connections.incoming, {
          ride = ride,
          timewaste = timewaste,
          bonus = bonus,
          risky = risky
        })
      end
    end
  end

  for i,ride in ipairs(rides) do
    table.sort(ride.connections.incoming, function(a, b) return a.timewaste > b.timewaste end)
    table.sort(ride.connections.outgoing, function(a, b) return a.timewaste > b.timewaste end)
  end

  return rides
end

return {compute=compute, compare=ride_compare}
