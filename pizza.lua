local tprint = require("tprint")

local T = 1
local M = 2


local R = 6
local C = 7
local L = 1
local H = 5

-- local R = 3
-- local C = 5
-- local L = 1
-- local H = 6

-- local input = {
--   {T, T, T, T, T},
--   {T, M, M, M, T},
--   {T, T, T, T, T}
-- }

local input = {
  {T, M, M, M, T, T, T},
  {M, M, M, M, T, M, M},
  {T, T, M, T, T, M, T},
  {T, M, M, T, M, M, M},
  {T, T, T, T, T, T, M},
  {T, T, T, T, T, T, M}
}

local tab = {}

for _, row in pairs(input) do
  local r = {}

  for _, cell in pairs(row) do
    table.insert(r, {
      val = cell,
      visited = 0,
      rects = {},
      filled = false
    })
  end

  table.insert(tab, r)
end

local rects = {
  {1, 6},
  {6, 1},
  {2, 3},
  {3, 2},
  {2, 2}
}

function does_it_fit(tab, pos, rect, needed)
  x, y = unpack(pos)
  w, h = unpack(rect)

  t_count = 0
  m_count = 0

  print("does_it_fit(tab, " .. tprint(pos) .. ", " .. tprint(rect) .. ", " .. needed .. ")")

  for i = y, y + h - 1 do
    for j = x, x + w - 1 do
      print(i..","..j)
      if not tab[i] then return false end
      cell = tab[i][j]

      if (not cell) or cell.filled then
        return false
      end

      if cell.val == T then
        t_count = t_count + 1
      elseif cell.val == M then
        m_count = m_count + 1
      end
    end
  end

  print("T: "..t_count.."; M: "..m_count)

  return (t_count >= needed) and (m_count >= needed)
end

function visit(tab, pos, rect)
  x, y = unpack(pos)
  w, h = unpack(rect)
  rect = {x, y, w, h}
  print("visit(tab, " .. tprint(pos) .. ", " .. tprint(rect) .. ")")

  for i = y, y + h - 1 do
    for j = x, x + w - 1 do
      cell = tab[i][j]
      cell.visited = cell.visited + 1
      table.insert(cell.rects, rect)
    end
  end

  return tab
end

for _, rect in pairs(rects) do
  for x = 1, C do
    for y = 1, R do
      if does_it_fit(tab, {x, y}, rect, L) then
        tab = visit(tab, {x, y}, rect)
      end
    end
  end
end

print(tprint(tab, {inline = false}))

