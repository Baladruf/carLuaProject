local filename = system.pathForFile("assets/save/valueHttp.json", system.ResourceDirectory)
local composer = require( "composer" )
local networkManager = require("scripts.networkmanager")
local scene = composer.newScene()
local ui = require("scripts.ui")
local json = require("json")
local elements
 
function scene:create( event )

    local sceneGroup = self.view
    elements = {}
end
 
 local grp 
 local w = screenW*0.4
local h = screenH*0.1
 
 
 local optionBack = {
	width = w, height = h, radius = 10, colors = {0.4,0.7, 0.9}, text="back", scene="scenes.menu"
}
 
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
	
 
    if ( phase == "will" ) then
	
	
		grp = display.newGroup()
		grp.x = halfW
		grp.y = halfH
		
		sceneGroup:insert(grp)
		
		local bBack = ui:makeTextButton(optionBack)
		bBack.y = halfH / 1.5
		grp:insert(bBack)
		
		local pres = display.newText({
                text = "Eric Escher",
                x = 0,
                y = -halfH / 1.5,
                font = native.systemFont,   
                fontSize = 48,
                align = "center"
                })
		grp:insert(pres)
		
		local photo = display.newImageRect(
			"assets/Cuisine.bmp", halfH , halfH
		)
		grp:insert(photo)
		
		
		--networkManager.get("https://api.fixer.io/2000-01-03?symbols=USD,GBP", function(data) table.print(data) end)
		
		
		
		--[[local stNum
		local tabEUR = {}
		
		local function addDataEUR(data)
			local file = io.open(filename, "a+")
			file.write(file, json.encode(data))
			io.close(file)
		end
		
		for i = 1, 12 do 
			if i < 10 then
				stNum = "0"..i 
			else 
				stNum = ""..i 
			end
			networkManager.get("https://api.fixer.io/2015-"..stNum.."-15?symbols=USD,GBP", addDataEUR(data))
		end
		
		print("begin print")--]]
		
		--[[local i, j
		local tempValue
		
		for i = 2, 12 do
			tempValue = tabEUR[i]
			j = i
			while(j > 0 and tabEUR[j - 1] > tempValue.rates)
		end--]]
		--[[for i = 1,20 do 
			local app = display.newRect(halfW, (i-1) * (10 + screenW*.2), screenW, screenW*.2)
			app.anchorY = 0
			grp:insert(app)
			app:setFillColor(i/20, 0 , 1 - i/20)
		end 
	
		function grp:limit()
		
			if (self.y > 0) then 
				self.y = 0 
				self.speed = -1*self.speed
			end 
			
			if (self.y < screenH - self.height) then 
				self.y = screenH - self.height
				self.speed = -1*self.speed
			end 
			

		end 
	
		function grp:touch(event)
			--for k,v in pairs(event) do 
			--	print(k..":"..tostring(v))
			--end 
		
			if (event.phase == "began") then 
				self.touchActive = true 
				self.yStart = self.y 
				self.lastTime = event.time 
			end 

			if (event.phase == "moved") then 
				self.y = self.yStart + (event.y - event.yStart)
				
				self.speed = (event.y - event.yStart)*1000/(event.time - self.lastTime)
				--self.lastTime = event.time 
				self:limit()
				
				
			end 		
			
			if (event.phase == "ended") or (event.phase == "cancelled")  then 
				self.lastTime = event.time 
				self.touchActive = false  
			end 
			
		end --]]


		--grp:addEventListener("touch", grp)
			
		--[[function grp:enterFrame(event)
			print("in enter")
			self.lastTime = self.lastTime or event.time 
			self.speed = self.speed or 0 
			if (self.touchActive == false) then 
				local diff = (event.time - self.lastTime)/1000	
				self.y = self.y + self.speed * diff 
				self.speed = self.speed * 0.7
				self:limit()
			end 
		end 
		
		Runtime:addEventListener("enterFrame", grp )
	
	
    elseif ( phase == "did" ) then --]]
		

    end
end
 

 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    
    local phase = event.phase
    if ( phase == "will" ) then
    elseif ( phase == "did" ) then
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
	elements = nil  
end
 
 
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
return scene