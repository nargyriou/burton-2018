local parser = require "parser"
local fd = io.stdin
local firstline = fd:read("*l")
local matrix = parser(fd)
print(require"tprint"(matrix, {inline=false}))

