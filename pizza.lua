local tprint = require("tprint")
local bruteforme = require("bruteformes")

local input = require "parsed.medium"
local mapvalues = require "mapvalues"


local T = mapvalues.T -- 1
local M = mapvalues.M -- 2


local R = input.R -- 6
local C = input.C -- 7
local L = input.L -- 1
local H = input.H -- 5

local rects = bruteforme(H)

local tab = {}

for _, row in ipairs(input) do
  local r = {}

  for _, cell in ipairs(row) do
    table.insert(r, {
      val = cell,
      rects = {},
      filled = false
    })
  end

  table.insert(tab, r)
end

function does_it_fit(tab, pos, rect, needed)
  local x, y = unpack(pos)
  local w, h = unpack(rect)

  local t_count = 0
  local m_count = 0

  -- print("does_it_fit(tab, " .. tprint(pos) .. ", " .. tprint(rect) .. ", " .. needed .. ")")

  for i = y, y + h - 1 do
    for j = x, x + w - 1 do
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

  return (t_count >= needed) and (m_count >= needed)
end

function visit(tab, pos, rect)
  local x, y = unpack(pos)
  local w, h = unpack(rect)
  local rect = {x, y, w, h}
  -- print("visit(tab, " .. tprint(pos) .. ", " .. tprint(rect) .. ")")

  for i = y, y + h - 1 do
    for j = x, x + w - 1 do
      cell = tab[i][j]
      table.insert(cell.rects, rect)
    end
  end

  return tab
end

local all_rects = {}

function try_place(tab, rect)
  local x, y, w, h = unpack(rect)

  -- Check if everything can be filled
  for i = y, y + h - 1 do
    for j = x, x + w - 1 do
      if tab[i][j].filled then
        return false
      end
    end
  end

  table.insert(all_rects, rect)

  -- and then fill the cells
  for i = y, y + h - 1 do
    for j = x, x + w - 1 do
      tab[i][j].filled = true
    end
  end

  return true
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

function rect_sort(a, b)
  local _, _, aw, ah = unpack(a)
  local _, _, bw, bh = unpack(b)
  local as = aw * ah
  local bs = bw * bh
  return as > bs
end

for n = 1, 20 do
  for x = 1, C do
    for y = 1, R do
      cell = tab[y][x]
      if not cell.filled then
        if #cell.rects == n then
          table.sort(cell.rects, rect_sort)
          for _, rect in pairs(cell.rects) do
            if try_place(tab, rect) then
              break
            end
          end
        end
      end
    end
  end
end

print(tprint(tab, {inline = false}))
print(tprint(all_rects))

