local function levelchanged(lvl, cfg)
	if lvl==1 then
		cfg.inline=true
		cfg.indent=""
	else
		cfg.inline=false
		cfg.indent=""
	end
	return cfg
end
local function matrixtofile(matrix,file)
	assert(file, "argument 2 missing filename")
	local tprint=require"tprint"
	local fd = io.open(file,"w")
	fd:write("return "..tprint(matrix, {levelchanged=levelchanged}).."\n")
end
return matrixtofile
