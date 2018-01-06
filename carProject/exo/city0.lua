

for i =1,8 do 
	local group = display.newGroup()
	local img = display.newImage("assets/bg/2/"..(9-i)..".png")
	local scale = screenH/img.height
	img.xScale = scale
	img.yScale = scale 
	img.x = halfW
	img.y = halfH
	group:insert(img)
end