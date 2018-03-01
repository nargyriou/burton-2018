local parser = require('./parser')
local tprint = require('./tprint')

print(tprint(parser(io.stdin), {inline=false}))
