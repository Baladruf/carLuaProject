
local composer = require( "composer" )
 
local scene = composer.newScene()

local elements
 
function scene:create( event )

    local sceneGroup = self.view
    elements = {}
end
 
local count = 0 
local _shown = false  
local _loaded = false 


local function checkGo()

	if (not _loaded) or (not _shown) then 
		return 
	end 
	
	print("go go go")
	
	local currentName = "img"..count..".jpg"

	local paint = {
		type = "image",
		filename = currentName,
		baseDir = system.DocumentsDirectory	
	}
	
	--display.newPolygon(halfW, halfH, {150,240, 170, 250, 100, 250, 10, 0} )
	
	local outline = graphics.newOutline(1, "assets/puzzle/piece1.png", system.ResourceDirectory)
	
	for k,v in ipairs(outline) do 
		print(k.."="..v)
	end 
	
	local txt = native.newTextField( halfW, screenH * 0.8, screenW*0.8, 50 )
	
	native.keyboardSetFocus(txt)
	
	local poly = display.newPolygon(halfW, halfH, outline )
	
	poly.fill = paint 
	poly.fill.rotation = 45
	
	poly.fill.effect = "filter.swirl"
	poly.fill.effect.intensity = 0
	
	transition.from(poly.fill.effect, {intensity = 0.5, time = 5000})
	

	
	--native.newTextBox 
	
	local font = native.newFont("Anja Eliane accent", 20)
	local text = display.newText("Hello", 100, 200)
	text.font = font 
	
	
	--url = 'http://millimages.cdn.mediactive-network.net/didou/dl/iphone/19/en_no.mp4'
	--media.playVideo( url, media.RemoteSource, true )
	
	
	
	
	--"Anja Eliane accent")
	
	
	
	--[[
	for i = 1,4 do
		for j = 1,3 do 
	
			local sq = display.newRect(0,0,200,200)
			sq.line = j 
			sq.col = i 
			sq.fill = paint 
			sq.x = i * 200 
			sq.y = j * 200 
			
			sq.fill.scaleX = 4
			sq.fill.scaleY = 3
			
			sq.fill.x = (i-0.5)/4 - 0.5
			sq.fill.y = (j-0.5)/3 - 0.5 
			
			sq.stroke = {1,1,1}
			sq.strokeWidth = 2
			transition.from(sq, {delay = 200, rotation = math.random(360), x = math.random(screenW*2) , y = math.random(screenH*2), time = 2000, transition = easing.inOutQuad})
		
		
		end 
	
	end 
	]]



end 


local function newGame(event) 
	_loaded = true 
	checkGo()
	event.target:removeSelf()
end 

local function prepare()
	count = count + 1
	local url = "https://picsum.photos/800/600" -- https://loremflickr.com/800/600	
	local name = "img"..count..".jpg"
	display.loadRemoteImage( url, "GET", newGame, name, system.DocumentsDirectory)
end 
 
function scene:show( event )
 
    local sceneGroup = self.view
	
    local phase = event.phase
 
    if ( phase == "will" ) then
		prepare()
	elseif ( phase == "did" ) then
		_shown = true
		checkGo()
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