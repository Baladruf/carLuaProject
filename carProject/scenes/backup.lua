
--[[

local t = os.date("*t")

table.simpleprint(t)



local function callback(event)
	print("in callback")
	table.simpleprint(event)
	print(event.source.msg) 
end

local function printWithDelay(t, msg)

	local t = timer.performWithDelay(t , callback, 20)
	t.msg = msg 
	timer.pause(t)
	timer.resume(t)
	
end 

printWithDelay(3000, "coucou")




local sheetOptions = require("assets.chars.templerun")

local sequenceData = {

	{name="dead", start =1, count= 10, time=1000, loopCount=1},
	{name="idle", start =11, count= 10, time=1000, loopCount=0},
	{name="jump", start =21, count= 10, time=1000, loopCount=1},
	{name="run", start =31, count= 10, time=1000, loopCount=0}
}


local sheet = graphics.newImageSheet("assets/chars/templerun.png", sheetOptions:getSheet()) 

-- print(sheet)

local sprite = display.newSprite(sheet, sequenceData)

sprite.x = halfW 
sprite.y = halfH

sprite.startY = sprite.y 
sprite.startX = sprite.x

sprite:setSequence("idle")


local function listener(event)
	--print("---------------")
	--for k,v in pairs(event) do 
	--	print(k..":"..tostring(v))
	--end 

	--if (event.phase == "loop") then 
	--	event.target:pause()
	--end 
	
end 


function sprite:jump()
	self.v = -350 
	self.isJumping = true 
	self:setSequence("jump")
	self:play()
end 


function sprite:key(event)

	print("---------------")
	for k,v in pairs(event) do 
		print(k..":"..tostring(v))
	end 
	
	if (event.keyName == "space") and (event.phase == "up") then 
		self:jump()
	end 
	
    	
end 







function sprite:enterFrame(event)

	self.lastTime = self.lastTime or event.time

	local diff = (event.time - self.lastTime)/1000
	self.lastTime = event.time 

	--print(diff)
	
	if (self.isJumping) then 
		print("jumping", self.y, self.v, diff)
		self.y = self.y + self.v * diff  
		self.v = self.v + 200*diff
	end 
	
	if (self.y > self.startY) then 
		self.isJumping = false 
		self.v = 0 
		self.y = self.startY
		self:setSequence("run")
		self:play()
	end 
	
end 



--function onEnterFrame(event)



--function sprite:tap(event)
 -- print("on tap")
  --table.simpleprint(event)
--	self:jump()
 --end 
 
 local grp = display.newGroup()
 
 
 
 
 function grp:touch(event)
	print("group is touched")
	return true 
 end 
 
grp:addEventListener("touch", grp )
grp:insert(sprite)


function touch_listener()
	print("runtime was touched")
end 

Runtime:addEventListener("touch", touch_listener)

 
function sprite:touch(event)
  print("on sprite touch")
  -- table.simpleprint(event)
	
	if (event.phase == "started") then 
		self.startX = self.x 
		self.startY = self.y
	end 
	
	if (event.phase == "moved") then 
				
		self.x = self.startX + (event.x - event.xStart) 
		self.y = self.startY + (event.y - event.yStart) 
	end 
	--return true 
	
  --self:jump()
 end 

 
--system.setTapDelay(200)


local opt = {
	x = 100, 
	y = 200, 
	text = "This is a very long text and it is going to wrap",
	width = 250, 
	align = "center", 
	fontSize = 35, 
	font = native.systemFont  
}

local txt = display.newText(opt)




function makeTextButton(options)

	options = options or {} 
	
	local width = options.width or 300 
	local height = options.height or 30 
	local radius = options.radius or 10 
	
	
	
	local  grp = display.newGroup()

	grp.params = options.params 
	
	grp.callback = options.onClick or function() print("no on click") end 

	
	local rect = display.newRect(grp, 0,0, width, height )
	
	local opt = {
		parent = grp,
		x = 0, 
		y = 0, 
		text = options.text or "NO TEXT ??",
		width = width,		
		align = "center", 
		fontSize = 35, 
		font = native.systemFont  
	}

	local txt = display.newText( opt)
	txt:setFillColor(0)
	
	function grp:tap(event)

		print("params", self.params)
	
		if (self.callback) then 
			self.callback(self.params)
		end 
	
	end 
	
	grp:addEventListener("tap", grp)
	
	return grp 
	
	-- width 
	-- height 
	-- text 
	-- onClick 
end 


local function play( params)
	print("in play")
	for k,v in pairs(params) do 
		print(k..":"..tostring(v))
	end 
   
    --for k,v in pairs(self) do 
	--	print(k..":"..tostring(v))
	--end 
   
 end 


local options = {
	width = 350, 
	height = 50, 	
	radius = 20,
	text="Play",
	onClick=play, 
	params = {score = 53}
}



local btn = makeTextButton(options)

btn.x = halfW 
btn.y = halfH 







sprite:addEventListener("touch", sprite)
sprite:addEventListener("sprite", listener)


Runtime:addEventListener("key", sprite)
Runtime:addEventListener("enterFrame", sprite)

sprite:play()

-- sprite:pause()

--sprite:setFrame(2)

--[[
local square = display.newRoundedRect(halfW, screenH*0.20, 100, 100,20)
square:setFillColor(1,0,0)

local t = {"a","b","c"}


for k,v in ipairs(t) do 
 print(k..":"..v)
end

local lastTime 

square.v = 0 

function fall(event)

	lastTime = lastTime or event.time 
	
	diff = (event.time - lastTime) / 1000 
	
	lastTime = event.time 

	square.y = square.y + square.v * diff 
	square.v = square.v + 30*diff 
	
	if (square.y >= screenH) then 
		square.v = -0.8*square.v 
	end 

end





Runtime:addEventListener("enterFrame", fall)



]]


--[[
function printObject(obj)

	print(obj.y)
	
	transition.to(obj, {time=2000, x = -200})

end 
]]

--[[
local options = {
	delay = 2000,
	time = 2000,
	y = -400, --screenH*0.8,
	--xScale=1.3,
	--yScale=1.3,
	transition= easing.outElastic,
	--iterations = 5,
	--delta = true,
	-- onComplete = printObject,
	--tag = "tag1"
}


local t = transition.from(square, options )

]]



--[[
transition.pause("tag1")
transition.resume(obj) / transition.resume(t) / transition.resume("tag")
transition.cancel()

]]

--image = display.newImage("assets/gameassets/jelly/jelly1.png", halfW, halfH)
--image:setFillColor(1,0,0,0.4)


-- circle = display.newCircle(halfW, halfH, halfW*0.2)


--sheetOptions = require("assets.gameassets.cars.cars")
--sheet = graphics.newImageSheet("assets/gameassets/cars/cars.png", sheetOptions:getSheet())




--[[
grp.anchorChildren = true 


local body = display.newImage( grp, sheet, sheetOptions:getFrameIndex("truckBody"), 0, 0  )
local head = display.newImage( grp, sheet, sheetOptions:getFrameIndex("truckHead"), 0, -body.height/2  )
local wheel1 = display.newImage( grp, sheet, sheetOptions:getFrameIndex("truckWheel"), -body.width/2, body.height/2  )
local wheel2 = display.newImage( grp, sheet, sheetOptions:getFrameIndex("truckWheel2"), body.width/2, body.height/2  )

grp.x = halfW
grp.y = halfH


local circle = display.newCircle(grp, 0,0, 15)

local circle2 = display.newCircle( halfW,halfH, 60)
circle2:setFillColor(1,1,1, 0.2)


local scale = screenH*0.25/grp.height 

grp.xScale = scale 
grp.yScale = scale 

grp.wheel1 = wheel1
grp.wheel2 = wheel2


local done = 0

local lastTime



function grp:enterFrame(event)

	if (done % 100 == 0) then 
	    for k,v in pairs(event) do 
	     print(" event."..k.." = "..tostring(v)) 
		end 
	    done = done + 1 
	end 
	
	lastTime = lastTime or event.time 
	
	local diff = (event.time - lastTime)/1000
	lastTime = event.time 
	
	
  self.wheel1.rotation = self.wheel1.rotation + 500*diff
  self.wheel2.rotation = self.wheel2.rotation + 500*diff
  
end 

-- groups : don' over use !!

function rotate()
 -- rect.rotation = rect.rotation + 1
end 


-- print(rect.width)

Runtime:addEventListener("enterFrame", grp)

groups = {}



--local container = display.newContainer(600,420)

--container.x = halfW 
--container.y = halfH 

for i = 8,1, -1 do 

	local grp = display.newGroup()
	--container:insert(grp)
	local img = display.newImage(grp, "assets/bg/2/"..i..".png")
	local img2 = display.newImage(grp, "assets/bg/2/"..i..".png")
	local img3 = display.newImage(grp, "assets/bg/2/"..i..".png")
	
	local scale = screenH/img.height 
	
	img.xScale = scale 
	img.yScale = scale 

	img2.xScale = scale 
	img2.yScale = scale 
	img3.xScale = scale 
	img3.yScale = scale 

	img.x = halfW 
	img.y = screenH - scale*img.height/2

	img2.y = img.y 
	img3.y = img.y

	img2.x = img.x - img.width*scale 
	img3.x = img.x + img.width*scale
		
	groups[i] = grp 
end 

groups[3]:insert(grp)

groups[8]:removeSelf()

groups[8] = nil 
]]