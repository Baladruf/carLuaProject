local composer = require( "composer" )

 

local ui = require("scripts.ui")
local json = require("json")

local scene = composer.newScene()

local loc = require("scripts.loc")

function gotoScene(scene)
	composer.gotoScene(scene, {
		time=2000, 
		effect ="fade"
	})
end 


local elements
 
function scene:create( event )

    local sceneGroup = self.view
    elements = {}
end
 
 
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then

    local filename = system.pathForFile("assets/save/intro.json", system.ResourceDirectory)
    local decode, pos, msg = json.decodeFile(filename)
    local introTxt
    local introTxtField
    local introButton


    if type(decode) == "string" then
        --table.print(decode)
        introTxt = display.newText({
                text = "Welcome "..decode,
                x = halfW,
                y = halfH,
                font = native.systemFont,   
                fontSize = 48,
                align = "center"
                })
        sceneGroup:insert(introTxt)
        composer.gotoScene("scenes.menu", {time=2000, effect ="fade"})
    else
        --table.print("val = "..(decode or "nil"))

        introTxt = display.newText({
                text = "Enter a name",
                x = halfW,
                y = halfH - halfH / 1.5,
                font = native.systemFont,   
                fontSize = 32,
                align = "center"
                })
        introTxtField = native.newTextField(halfW, halfH - halfH / 5, 300, 30)

        local function onButtonEvent()
            if string.len(introTxtField.text) > 2 then
                local file = io.open(filename, "w+")
                file.write(file, json.encode(introTxtField.text))
                io.close(file)
                print("before goto scene")
                composer.gotoScene("scenes.menu", {time=2000, effect ="fade"})
            else 
                introTxt.text = "Choose name with 3 letters or more"
            end
        end
        introButton = ui:makeTextButton({
            text = "GO",
            width = 300,
            height = 100,
            radius = 10,
            callback = onButtonEvent
        })
        introButton.x = halfW
        introButton.y = halfH + halfH / 3
        --introButton.text = "GO"
        sceneGroup:insert(introTxt)
        sceneGroup:insert(introTxtField)
        sceneGroup:insert(introButton)


        --local file = io.open(filename, "w+")
        --file.write(file, json.encode("TEST"))
        --io.close(file)



    end


    elseif ( phase == "did" ) then
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