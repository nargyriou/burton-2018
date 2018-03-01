local function diff(start, finish)
  return math.abs(start.col - finish.col) + math.abs(start.row - finish.row)
end

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
  while true do
    local txtline = fd:read("*l")

    if not txtline then break end

    local row_start, col_start, row_finish, col_finish, start, finish = string.match(firstline, "([0-9]+) ([0-9]+) ([0-9]+) ([0-9]+) ([0-9]+) ([0-9]+)")

    local ride = {
      start={
        row=tonumber(row_start),
        col=tonumber(col_start),
        step=tonumber(start),
      },
      finish={
        row=tonumber(row_finish),
        col=tonumber(col_finish),
        step=tonumber(finish),
      }
    }

    ride.cost = diff(ride.start, ride.finish)

    table.insert(data, ride)
  end

  data.R = R
  data.C = C
  data.F = F
  data.N = N
  data.B = B
  data.T = T

  return data
end

return parser

-- vim:set noet sts=2 sw=2 ts=2:
