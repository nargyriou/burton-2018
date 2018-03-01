local function diff(start, finish)
  return math.abs(start.col - finish.col) + math.abs(start.row - finish.row)
end

local function is_doable(ride, pos, step)
  local cost = diff(ride.start, pos)
  return (step + cost) > ride.deadline
end

return {diff=diff}

-- vim:set noet sts=2 sw=2 ts=2:
