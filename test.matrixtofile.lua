local parser = require "parser"
local fd = io.stdin
local mapvalues = require "mapvalues"
local matrix = parser(fd, mapvalues)
local matrixtofile = require"matrixtofile"
matrixtofile(matrix,assert(arg[1], "missing output filename"))
