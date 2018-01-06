
local groups = {}


for i =1,8 do 
	local group = display.newGroup()

	local filename = "assets/bg/2/"..(9-i)..".png"

	local prevImg = display.newImage(filename)
	local img = display.newImage(filename)
	local nextImg = display.newImage(filename)


	local scale = screenH/img.height
	img.xScale = scale
	img.yScale = scale 
	img.x = halfW
	img.y = halfH

	prevImg.xScale, prevImg.yScale = scale, scale 
	nextImg.xScale, nextImg.yScale = scale, scale 

	nextImg.y = img.y 
	prevImg.y = img.y 

	print(i, screenW, img.width)

	prevImg.x = img.x - img.width * scale
	nextImg.x = img.x + img.width * scale  
	
	

	group:insert(img)
	group:insert(nextImg)
	group:insert(prevImg)
	
	group.depth = 10 - i 
	

	table.insert(groups, group)
end

local v = 1

local previousTimestamp 

local myListener = function( event )
    
    local currentTimestamp = event.time/1000
	previousTimestamp = previousTimestamp or currentTimestamp
	local elapsedtime = currentTimestamp - previousTimestamp 
	previousTimestamp =currentTimestamp

    for i = 1,8 do 
    	local group = groups[i]
    	group.x = group.x + v * (100 -  group.depth*10)*elapsedtime
    end 

    if groups[8].x > halfW then 
    	v = -1
    elseif groups[8].x < 0 then 
    	v = 1
    end 


end
