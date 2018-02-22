local parser = require "parser"
local fd = io.stdin
local firstline = fd:read("*l")
local matrix = parser(fd)
local matrixtofile = require"matrixtofile"
matrixtofile(matrix,assert(arg[1], "missing output filename"))
