
local public = {}

function public.init(trackObj)
	trackObj.lx = trackObj.x
	--trackObj.ly = trackObj.y
end

function public.update(trackObj, world)
	local dx = trackObj.x - trackObj.lx
	--local dy = trackObj.y - trackObj.ly
	
	trackObj.lx = trackObj.x
	--trackObj.ly = trackObj.y
	
	world.x = world.x - dx
	--[[if para and table.getn(para) > 0 then
		for i = 1, table.getn(para) do 
			--table.print(para[i].im1._class)
			para[i].im1.x = 0--(para[i].im1.x - dx) / i
			para[i].im2.x = (para[i].im2.x - dx) / i
			para[i].im3.x = (para[i].im3.x - dx) / i
		end
	end--]]
	--trackObj.x = trackObj.lx
	--world.y = world.y - dy
	return dx
end

return public