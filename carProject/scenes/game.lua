local composer = require("composer")
local ui = require("scripts.ui")
local scene = composer.newScene()
local physics = require("physics")
local cameraG = require("scripts.camera")

local groups = {}
local groupGround
local lastPos = {}

local world
local player
local canDrawLine = false
local grpButton
local scale

local paral = {}

local function makeCar(id)
	
    id = id or 1
    local names = {"truck","orc", "girl"}
    name = names[id] or "truck"

    local sheetOptions = require("assets.gameassets.cars.cars")
    local sheet = graphics.newImageSheet("assets/gameassets/cars/cars.png", sheetOptions:getSheet())


	local scale = 0.3

	local car = {}

	car.body = display.newImage( sheet, sheetOptions:getFrameIndex(name.."Body"), 0, 0)

	print(car.body)

	car.head = display.newImage( sheet, sheetOptions:getFrameIndex(name.."Head"), 0, 0)
	car.wheel1 = display.newImage( sheet, sheetOptions:getFrameIndex(name.."Wheel"), 0, 0)
	car.wheel2 = display.newImage( sheet, sheetOptions:getFrameIndex(name.."Wheel2"), 0, 0)

	world:insert(car.head)
	world:insert(car.body)
	world:insert(car.wheel1)
	world:insert(car.wheel2)
	--car.body.xScale = scale 
	--car.body.yScale = scale 
	--car.head.xScale = scale 
	--car.head.yScale = scale 
	--car.wheel1.xScale = scale 
	--car.wheel1.yScale = scale 
	--car.wheel2.xScale = scale 
	--car.wheel2.yScale = scale 
	
	
	car.body.width = car.body.width * 0.3
	car.body.height = car.body.height * 0.3
	
	car.head.width = car.body.width * 0.3
	car.head.height = car.body.height * 0.3
	
	car.wheel1.width = car.body.width * 0.3
	car.wheel1.height = car.wheel1.width
	
	car.wheel2.width = car.body.width * 0.3
	car.wheel2.height = car.wheel2.width

	car.wheel1.alpha = 0.7
	car.wheel2.alpha = 0.7 

	car.body.x = halfW 
	car.body.y = halfH


	car.head.x, car.head.y = car.body.x - 20, (car.body.y - car.body.contentHeight*.5) - 13
	car.wheel1.x, car.wheel1.y = car.body.x -car.body.contentWidth*.37, car.body.y + car.body.contentHeight*.43
	car.wheel2.x, car.wheel2.y = car.body.x + car.body.contentWidth*.31, car.body.y + car.body.contentHeight*.43

	
	physics.addBody(car.body, "dynamic")
	physics.addBody(car.head, "dynamic")
	physics.addBody(car.wheel1, "dynamic", { density=1.0, friction=0.3, bounce=0.2, radius=car.wheel1.width / 2 })
	physics.addBody(car.wheel2, "dynamic", { density=1.0, friction=0.3, bounce=0.2, radius=car.wheel2.width / 2 })
	
	physics.newJoint("pivot", car.wheel1, car.body, car.wheel1.x, car.wheel1.y) --  attache les roues et la tete au corps
	physics.newJoint("pivot", car.wheel2, car.body, car.wheel2.x, car.wheel2.y)
	physics.newJoint("pivot", car.head, car.body, car.head.x, car.head.y)
	

	return car 


end 

local function makeChar ()

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
	sprite.xScale = 0.35 
	sprite.yScale = 0.35 
	
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

	--sprite.jumpCount = 0 
	
	function sprite:jump()
	    --sprite.jumpCount = sprite.jumpCount + 1 
		--self.isJumping = true 
		--if (sprite.jumpCount > 2) then 
		--	return 
		--end 
		self:setSequence("jump")
		self:play()
		self:applyLinearImpulse(0, -1.5, 0,0)
	end 

	function sprite:run(right)
	    --sprite.jumpCount = sprite.jumpCount + 1 
		--self.isJumping = true 
		--if (sprite.jumpCount > 2) then 
		--	return 
		--end 
		local mult = 1
		if (not right) then 
			mult = -1 
		end 
		
		self:setSequence("run")
		self:play()
		self:applyLinearImpulse(mult*0.1, 0, 0,0)
	end 

	function sprite:key(event)

		print("---------------")
		for k,v in pairs(event) do 
			print(k..":"..tostring(v))
		end 
		
		if (event.keyName == "space") and (event.phase == "up") then 
			self:jump()
		end 

		if (event.keyName == "left") and (event.phase == "down") then 
			self:run(false)
		end 
		if (event.keyName == "right") and (event.phase == "down") then 
			self:run(true)
		end 
		
	end 
	
	Runtime:addEventListener("key", sprite)
	sprite:setSequence("idle")
	sprite:play()	
	return sprite
	
end 





function scene:create(event)

	physics.start()
	physics.setDrawMode("hybrid")
	
	-- scene.view 
	
	--local scale
	
	local grps = display.newGroup()
	groupGround = display.newGroup()
	local sky = display.newImage(grps, "assets/bg/2/8.png")
	local sun = display.newImage(grps, "assets/bg/2/7.png")
	sky.xScale = screenW
	sky.yScale = screenH
	sun.xScale = screenH/sun.height
	sun.yScale = screenH/sun.height
	sun.x = halfW
	sun.y = screenH - (screenH/sun.height)*sun.height/2 -- ciel et soleil detacher des paralaxes (pas besoin de faire bouger sa)
	
	function sky:touch(event)
		--print("touch")
		if canDrawLine then -- si bouton draw line active
			if event.phase == "began" then
				--table.print(event)
				--lineBegin = {event.xStart, event.yStart}
			elseif event.phase == "ended" then
				local lineTemp = display.newLine(event.xStart, event.yStart, event.x, event.y) -- on trace une ligne 
				lineTemp:setStrokeColor(1, 0, 0)
				lineTemp.strokeWidth = 5
				
				--[[local body = display.newRect( 150, 200, 40, 40 )
 
				physics.addBody( body, "static",
					{
						chain={ -120,-140, -100,-90, -80,-60, -40,-20, 0,0, 40,0, 70,-10, 110,-20, 140,-20, 180,-10 },
						connectFirstAndLastChainVertex = true
					}
				)--]]
				
				physics.addBody(lineTemp, "static", { bounce = 1, density=0.3, friction=0.7}) -- ajout collider 
				lineTemp.x = lineTemp.x - world.x -- on place correctement la ligne (sinon conflit avec la position world)
				world:insert(lineTemp)
				local function destroyLine()
					lineTemp:removeSelf()
				end
				timer.performWithDelay( 20000, destroyLine ) -- apres 20s destroy line
				--table.print(lineTemp)
			end
		end
	end
	sky:addEventListener("touch", sky)
	--sky.x = halfW
	--sky.y = screenH - (screenH/sky.height)*sky.height/2
	
	groups[7] = grps
	
	for i = 6,1, -1 do -- paralaxe

	
		--local groupPara = display.newGroup()
		--container:insert(grp)
		local img = display.newImage("assets/bg/2/"..i..".png")
		local img2 = display.newImage("assets/bg/2/"..i..".png")
		local img3 = display.newImage("assets/bg/2/"..i..".png")
		
		scale = screenH/img.height
		
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
		
		local im = {}
		im[1] = img
		im[2] = img2
		im[3] = img3
		paral[i] = im
		
		if (i == 1 ) then 

			world = display.newGroup()
			--img2.x = img.x - img.width * scale / 1.15
			--physics.addBody(img, "static", {bounce = 0, box = { halfWidth=img.width/2, halfHeight=screenH*0.9, x=img.width, y=img.height}})
			--physics.addBody(img2, "static", {bounce = 0, box = { halfWidth=img2.width/2, halfHeight=screenH*0.9, x=0, y=0}})
			--physics.addBody(img3, "static", {bounce = 0, box = { halfWidth=img3.width/2, halfHeight=screenH*0.9, x=0, y=0}})
			
			local f = display.newRect(world, screenW * 25, screenH*0.9, screenW * 50, screenH*0.22) -- sol collider
			f.alpha = 0 
			physics.addBody(f, "static", {bounce = 0, friction = 0.95})
			lastPos.x = img3.x
			lastPos.width = (img3.width * scale)
			
			local b = display.newRect(world, halfW / 9, halfH, halfW / 10, screenH * 3) -- mur pour ne pas trop reculer
			physics.addBody(b, "static")
			b:setFillColor(0.3, 0.3, 0.3)
			--[[local obs = display.newRect(world, img3.x / 2, screenH*0.9, screenW * 5, screenH*0.22)
			obs:setFillColor(1, 0.7, 0)
			physics.addBody(obs, "static", {bounce = 0})
			obs.rotation = -20--]]
			
			--groupGround:insert(img)
			--groupGround:insert(img2)
			--groupGround:insert(img3)
		end 
		
		
		
		groups[i] = grp 

	end 
	
	local posxObs = halfW + halfW / 1.5 -- spaawn d'obstacle generer proceduralement
		for i = 1, math.random(8, 20) do
			aleaSize = math.random(20, 50)
			local obs = display.newImageRect("assets/physics/crateB.png", aleaSize * screenH / 100, aleaSize * screenH / 100)
			obs.x = posxObs
			obs.y = screenH *0.8 - (aleaSize * screenH / 200)

			posxObs = posxObs + ((aleaSize * screenH / 100) + math.random(0, halfW))
			physics.addBody(obs, "static")
			world:insert(obs)
		end
	
	grpButton = display.newGroup()
	local bForward = display.newCircle(grpButton, halfW + (halfW / 1.4), halfH / 2, screenH / 20) -- bouton avancer
	local bBack = display.newCircle(grpButton, halfW / 4, halfH / 2, screenH / 20) -- bouton reculer
	local bTraceLigne = display.newCircle(grpButton, halfW, halfH / 4, screenH / 20) -- si actif permet de tracer des lignes
	bForward:setFillColor(0, 1, 0.3)
	bBack:setFillColor(0, 0.8, 1)
	bTraceLigne:setFillColor(0.7, 0.1, 0.9)
	bForward.tag = "forward"
	bBack.tag = "back"
	function bForward:touch(event)
		local posx, posy = player:getLinearVelocity()
		if posx < 5 then 
			player:applyForce( 150, 0, player.x, player.y )
		else
			player:setLinearVelocity(100, 0)
		end
	end
	function bBack:touch(event)
		local posx, posy = player:getLinearVelocity()
		if posx > -5 then 
			player:applyForce( -150, 0, player.x, player.y )
		else
			player:setLinearVelocity(-100, 0)
		end
	end
	function bTraceLigne:tap(event)
		canDrawLine = not canDrawLine
		if canDrawLine then
			bTraceLigne:setFillColor(0.9, 0.1, 0.7)
		else
			bTraceLigne:setFillColor(0.7, 0.1, 0.9)
		end
	end
	bForward:addEventListener("touch", bForward)
	bBack:addEventListener("touch", bBack)
	bTraceLigne:addEventListener("tap", bTraceLigne)
	function quit()
		os.exit()
	end
	local btnQuit = ui:makeTextButton({ width = halfW / 5, height = halfH / 5, radius = 10, colors = {0.4,0.7, 0.9}, text="quit", callback=quit}) -- bouton quit
	btnQuit.x, btnQuit.y = btnQuit.width / 2, btnQuit.height / 2
	grpButton:insert(btnQuit)
	--local platform = display.newRect(halfW, halfH, screenW*0.3, 40)
	--physics.addBody(platform, "static")
	
	local car = makeCar(1) -- creation du player
	
	player = car.wheel1
	cameraG.init(player) -- init camera
	
	function player:enterFrame(event) -- a toutes les frames reposition du monde par rapport au player (need script camera)
		--table.print(cameraG)
		local dx = cameraG.update(player, world)
		for i = 1, 6 do 
			local grBack = paral[i]
			local scaleX = grBack[1].xScale
			for j = 1, 3 do 
				grBack[j].x = grBack[j].x - (dx / i)
				
				if grBack[j].x + grBack[j].width/2 * scaleX > grBack[j].width * 3/2 then --screenW --[[grBack[j].x < -screenW--]] then
					--grBack[j].x = screenW
					grBack[j].x = grBack[j].x - grBack[j].width * scaleX * 3
				elseif grBack[j].x + grBack[j].width/2 * scaleX < -grBack[j].width * 3/2 --[[grBack[j].x > screenW--]] then 
					grBack[j].x = grBack[j].x + grBack[j].width * scaleX * 3
				end
			end
		end
	end

		--[[for x = 1, 6, 1 do
	         parallaxPlan = groups[x]
	         scale = parallaxPlan[0].xScale
	         if delta > 0 then
	             for i = 0, 2, 1 do
	                 plan = parallaxPlan[i]
	                 plan.x = plan.x - delta / x
	                 if ((plan.x + plan.width/2 * scale) < 0) then
	                     plan.x = plan.x + plan.width * scale * 3
	                 end
	             end
	         elseif delta < 0 then
	             for i = 0, 2, 1 do
	                 plan = parallaxPlan[i]
	                 plan.x = plan.x - delta / x
	                 if ((plan.x - plan.width/2 * scale) > screenW) then
	                     plan.x = plan.x - plan.width * scale * 3
	                 end
	             end
	         end
	     end--]]
	Runtime:addEventListener("enterFrame", player)
	--local char = makeChar()
	--physics.addBody(car.grpRL, "dynamic", {bounce = 0, box = {halfWidth = .35*car.wheel1.contentWidth, halfHeight = .5*car.wheel1.contentHeight}})
	--physics.addBody(car.grpRR, "dynamic", {bounce = 0, box = {halfWidth = .35*car.wheel2.contentWidth, halfHeight = .5*car.wheel2.contentHeight}})
	--char.isFixedRotation = true 
end 

--[[
local function loadJson(path, directory)

	directory = directory or system.DocumentsDirectory
	print(directory)
	print(path)
	local realPath = system.pathForFile(path, directory)
	if not realPath then 
		error("no such file : "..path)
	end 
	
	local file, err = io.open(realPath, "r") -- "w"
	
	if not file then 
		error(err)
	else 
		local data = file:read("*a")

		if (data) then 
			return json.decode(data)
		end 
	end 


end
]]


	
function scene:show(event)
	if (event.phase == "will") then 
	
		
		grpButton.isVisible = false -- anime 1-2-3-go
		local sheetOptions = require("assets.go")
		local sheet = graphics.newImageSheet("assets/go.png", sheetOptions:getSheet()) 
		local dataGo = {{name="go", start =1, count= 4, time=4000, loopCount=1}}
		local spriteGo = display.newSprite(sheet, dataGo)
		spriteGo.x = halfW 
		spriteGo.y = halfH
		spriteGo:setSequence("go")
		local function play()
			spriteGo:play()
			local function active()
			spriteGo:removeSelf()
			grpButton.isVisible = true
			end
			timer.performWithDelay(4000, active)
		end
		timer.performWithDelay(1000, play)
		--[[
		local data = table.load("assets/particles/spark.json", system.ResourceDirectory)
		if (data) then 
			for k,v in pairs(data) do 
				print(" data."..k..":"..v)
		end 
			local emitter = display.newEmitter(data, system.ResourceDirectory) 
			emitter.x = halfW 
			emitter.y = halfH 
			emitter.alpha = 0.2
			transition.to(emitter, {delay= 1000, time=1000, y = 100})
		else 
			error("no data returned")
		end 
		]]
	
	
	
	
	end 

end 

function scene:destroy( event )
	

end

function scene:hide( event )


end
	
scene:addEventListener("create", scene )
scene:addEventListener("destroy", scene)
scene:addEventListener("show", scene )
scene:addEventListener("hide", scene )


return scene 
 






	