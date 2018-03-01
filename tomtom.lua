local parser = require('./parser')
local tprint = require('./tprint')

print(tprint(parser(io.stdin), {inline=false}))

-- vim:set noet sts=2 sw=2 ts=2:
