
local public = {}

function public.init(trackObj)
	trackObj.lx = trackObj.x
	--trackObj.ly = trackObj.y
end

function public.update(trackObj, world, lineL)
	local dx = trackObj.x - trackObj.lx
	--local dy = trackObj.y - trackObj.ly
	
	trackObj.lx = trackObj.x
	--trackObj.ly = trackObj.y
	
	world.x = world.x - dx
	if lineL and table.getn(lineL) > 0 then
		for i = 1, table.getn(lineL) do 
			lineL[i].x = lineL[i].x - dx
		end
	end
	--trackObj.x = trackObj.lx
	--world.y = world.y - dy
end

return public