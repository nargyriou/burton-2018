
local args = arg
local filename = (args[1] or "example")
local bigger_first = true

local debugprint = function(msg, ...)
	if #{...}>0 then
		local t={msg}
		for _i, o in ipairs({...}) do
			table.insert(t, tostring(o))
		end
		msg = table.concat(t,"\t")
	end
	io.stderr:write(msg.."\n")
end

local gc = function(a) debugprint("gc()") collectgarbage() end
local mem = function() debugprint("mem(MB):"..string.format("%.2f", collectgarbage("count")/1024)) end
mem()
local tprint = require("tprint")
local bruteforme = require("bruteformes")

mem()
local Input = require ("parsed."..filename)
debugprint("Input loaded", #Input[1], #Input)
mem()
local mapvalues = require "mapvalues"


local T = mapvalues.T -- 1
local M = mapvalues.M -- 2


local R = Input.R -- 6
local C = Input.C -- 7
local L = Input.L -- 1
local H = Input.H -- 5

local rects = bruteforme(H)
debugprint("bruteforme:", #rects)

local order_desc = function(va,vb)
	return (va[1]*va[2] > vb[1]*vb[2])
end
local order_asc = function(va,vb)
	return (va[1]*va[2] < vb[1]*vb[2])
end

table.sort(rects, bigger_first and order_desc or order_asc)

for _i,v in ipairs(rects) do
	debugprint("", "-", v, v[1]*v[2])
end
mem()

local Rects = {}  -- tab[y][x].rects => Rects[y][x]
local Filled = {} -- tab[y][x].filled => Filled[y][x]
for j, row in ipairs(Input) do
  if not Rects[j] then Rects[j] = {} end
  if not Filled[j] then Filled[j] = {} end
  for i in ipairs(row) do
    Rects[j][i] = {}
    Filled[j][i] = false
  end
end

debugprint("Rects:", #Rects[1], #Rects)
debugprint("Filled:", #Filled[1], #Filled)
mem()

local function does_it_fit(pos, rect, needed)
  local x, y = unpack(pos)
  local w, h = unpack(rect)

  local t_count = 0
  local m_count = 0

  --debugprint("does_it_fit(tprint(pos) .. ", " .. tprint(rect) .. ", " .. needed .. ")")

  local val
  for j = y, y + h - 1 do
    for i = x, x + w - 1 do
      if not Input[j] then return false end
      val = Input[j][i]

      if (not val) or Filled[j][i] then
        return false
      end

      if val == T then
        t_count = t_count + 1
      elseif val == M then
        m_count = m_count + 1
      end
    end
  end

  return (t_count >= needed) and (m_count >= needed)
end

local function visit(pos, rect)
  local x, y = unpack(pos)
  local w, h = unpack(rect)
  local rect = {x, y, w, h}
  --debugprint("visit(tprint(pos) .. ", " .. tprint(rect) .. ")")
  for j = y, y + h - 1 do
    for i = x, x + w - 1 do
      table.insert(Rects[j][i], rect)
    end
  end
end

local All_rects = {}

local function try_place(rect)
  local x, y, w, h = unpack(rect)

  -- Check if everything can be filled
  for j = y, y + h - 1 do
    for i = x, x + w - 1 do
      if Filled[j][i] then
        return false
      end
    end
  end

  table.insert(All_rects, rect)

  -- and then fill the cells
  for j = y, y + h - 1 do
    for i = x, x + w - 1 do
      Filled[j][x] = true
    end
  end

  return true
end

mem()
debugprint("# before ipairs(rects) => rect/C/R/does_it_fit/visit")
for _, rect in ipairs(rects) do
  for x = 1, C do
    --debugprint("does_it_fit: {"..x..",".."*".."} "..L)
    for y = 1, R do
      if does_it_fit({x, y}, rect, L) then
        visit({x, y}, rect)
      end
    end
  end
  --gc()
  --mem()
end
mem()
gc();gc()
mem()

local function rect_sort(a, b)
--[[
  local _, _, aw, ah = unpack(a)
  local _, _, bw, bh = unpack(b)
  local as = aw * ah
  local bs = bw * bh
  return as > bs
]]--
  return (a[3]*a[4]) > (b[3]*b[4])
end

mem()
debugprint("BEGIN line 124")

local val
local nmax= 20 -- pourquoi 20 ? ca serait pas #rects ?
nma=#rects
for n = 1, nmax do
  for x = 1, C do
    for y = 1, R do
      --debugprint("n="..n, "x="..x, "y="..y)
      --mem()
      val = Input[y][x]
      if not Filled[y][x] then
        if #Rects[y][x] == n then
          table.sort(Rects[y][x], rect_sort)
          for _, rect in ipairs(Rects[y][x]) do
            if try_place(rect) then
              break
            end
          end
        end
      end
    end
  end
end
mem()
debugprint("ENDED line 144")
-- debugprint(tprint(Input, {inline = false}))
mem()
gc();gc()
mem()

print(#All_rects)
for _, rect in ipairs(All_rects) do
  local x, y, w, h = unpack(rect)
  -- out files indexes start at zero
  print(table.concat({y - 1, x - 1, y + h - 2,  x + w - 2}, " "))
end

