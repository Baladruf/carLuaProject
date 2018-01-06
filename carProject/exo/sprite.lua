-- sprite.lua


local sheetInfo = require("assets.chars.templerun")
local sheet = graphics.newImageSheet("assets/chars/templerun.png", sheetInfo:getSheet())


local function makeAnim(anim)

	local frames = {}

	i = 1 
	local frame 

	repeat 
		frame = sheetInfo:getFrameIndex(anim.."__00"..i)
		if (frame) then 
			frames[i] = frame 
		end 
		i = i + 1
	until(frame == nil) 

	return { name=anim, time=i*100, frames = frames, loopCount = 1}
end 

local names = {"Idle", "Run", "Slide","Jump", "Dead"}

local animations = {}

for i = 1, 5 do 
	animations[i] = makeAnim(names[i])
end 

local sprite = display.newSprite( sheet, animations )

sprite.x = halfW
sprite.y = halfH


local index = 1

local function listener(event)

	if (event.phase == "ended") then
		index = index + 1 
		if names[index] then 
            event.target:setSequence(names[index])
            event.target:play()
        else
            event.target:removeSelf()
        end
    end
end 


sprite:addEventListener( "sprite", listener )

sprite:play()


