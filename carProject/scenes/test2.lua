
local composer = require( "composer" )
 
local scene = composer.newScene()

local elements
 
function scene:create( event )

    local sceneGroup = self.view
    elements = {}
end
 
 
function scene:show( event )
 
    local sceneGroup = self.view
	
    local phase = event.phase
 
    if ( phase == "will" ) then

	elseif ( phase == "did" ) then


		local rect = display.newCircle(halfW, halfH, 200) --, 200)
		
		-- local paint = {1,0,1}
		local gradient = {
			type = "gradient",
			color1 = {1,0,0},
			color2 = {1,0,1},
			direction = "left"
		}
		
		local paint = {
			type = "image",
			filename = "kitten",
			baseDir = system.DocumentsDirectory
		}
		
		rect.fill = paint 
		
		rect.fill.scaleX = 1
		rect.fill.scaleY = 1
		rect.fill.x = 0
		rect.fill.y = 0.5
		
		rect.stroke = gradient 
		--rect:setFillColor(1,0,0)
		--rect:setStrokeColor(0,0,1)
		rect.strokeWidth = 20
		
		





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