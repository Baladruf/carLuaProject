_corona = false

require("constants")
require("utils")
require("setup")
require("scripts.tools")

display.setDefault("background",0.3,0.3,0.3)

print(" Max texture size on this device : ", system.getInfo( "maxTextureSize" ))

customFont = "Anja Eliane accent"

local composer = require("composer")


local options = {

	effect = "slideUp", 
	time = 1000, 
	params = {
		level = 42 
	}

} 


composer.gotoScene("scenes.load", options)

