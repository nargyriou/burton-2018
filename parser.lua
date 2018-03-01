local utils = require('utils')

local function parser(fd)
  local firstline = fd:read("*l")
  local R,C,F,N,B,T = string.match(firstline, "([0-9]+) ([0-9]+) ([0-9]+) ([0-9]+) ([0-9]+) ([0-9]+)")
  R,C,F,N,B,T = tonumber(R), tonumber(C), tonumber(F), tonumber(N), tonumber(B), tonumber(T)

  assert(type(R) == "number", "R is invalid") -- number of rows of the grid ( 1 ≤ R ≤ 10 000)
  assert(type(C) == "number", "C is invalid") -- number of columns of the grid ( 1 ≤ C ≤ 10 000)
  assert(type(F) == "number", "F is invalid") -- number of vehicles in the fleet ( 1 ≤ F ≤ 1 000)
  assert(type(N) == "number", "N is invalid") -- number of rides ( 1 ≤ N ≤ 10 000)
  assert(type(B) == "number", "B is invalid") -- per-ride bonus for starting the ride on time ( 1 ≤ B ≤ 10 000)
  assert(type(T) == "number", "T is invalid") -- number of steps in the simulation ( 1 ≤ T ≤ 10^9 )

  local data = {}
  local current_id = 0
  while true do
    local txtline = fd:read("*l")

    if not txtline then break end

    local row_start, col_start, row_finish, col_finish, start, finish = string.match(firstline, "([0-9]+) ([0-9]+) ([0-9]+) ([0-9]+) ([0-9]+) ([0-9]+)")

    local ride = {
      id = current_id,
      start = {
        row = tonumber(row_start) + 1,
        col = tonumber(col_start) + 1,
        step = tonumber(start),
      },
      finish = {
        row = tonumber(row_finish) + 1,
        col = tonumber(col_finish) + 1,
        step = tonumber(finish),
      },
      started_on = nil -- step at which the ride was took
    }

    ride.cost = utils.diff(ride.start, ride.finish)
    ride.deadline = ride.finish.step

    current_id = current_id + 1

    table.insert(data, ride)
  end

  data.R = R -- number of rows of the grid
  data.C = C -- number of columns of the grid
  data.F = F -- number of vehicles in the fleet
  data.N = N -- number of rides
  data.B = B -- per-ride bonus for starting the ride on time
  data.T = T -- number of steps in the simulation

  return data
end

return parser

-- vim:set noet sts=2 sw=2 ts=2:
