local ui = {}

local colors = table.load("assets/ui/colors.json", system.ResourceDirectory)


local function hex2rgb(hex)


	--string.sub(s, i, [j]) -> substring s des i à j 
	-- s:sub(-1) = o 
	-- j = j or s:len()
	local r = tonumber("0x"..hex:sub(2,3))/255
	local g = tonumber("0x"..hex:sub(4,5))/255
	local b = tonumber("0x"..hex:sub(6,7))/255
	return {r,g, b}

end 



for color,palette in pairs(colors) do 

	for key, hexcode in pairs(palette) do 
		colors[color][key] = hex2rgb(hexcode)

	end 


end 

local function getColorUnpacked(name, key)
	return unpack(colors[name or "orange"][key or "500"])
end 






function ui:makeCursor(options)

	local width = options.width or 300 
	local height = options.height or 30

	local pct = options.pct  

	local grp = display.newGroup()

	local cursor = display.newRect(grp, 0,0, 30, height)
	local line = display.newLine(grp, 0,0,width,0)
	line.strokeWidth = 3

	cursor.onUpdate = options.onUpdate 

	cursor.xStart = cursor.x 
	
	function cursor:touch(event)
	
		--for k,v in pairs(event) do 
		--	print(k..":"..tostring(v))
		--end 
	
		if (event.phase == "began") then 
			self.xStart = self.x 
		end 

		if (event.phase == "moved") then 
			self.x = self.xStart + event.x - event.xStart
			
			if (self.x < 0) then 
				self.x = 0 
			end 
			
			if (self.x > width) then 
				self.x = width
			end 
			
			self.onUpdate( self.x / self.width )
		
		end 
	
	end 
	
	cursor:addEventListener("touch", touch)
	
	return grp

end 




function ui:makeTextButton(options)

	options = options or {} 
	
	local width = options.width or 300 
	local height = options.height or 30 
	local radius = options.radius or 10 
	local colors = options.colors 
	
	local sound = options.sound --"asset/click.wav"
	
	local handle 
	local channel 
		
	local grp = display.newGroup()

	grp.data = options

	if (sound) then 
		grp.handle = audio.loadSound(sound) -- audio.loadStream("AllumezleFeu.mp3")	
	end 

	
	local rect = display.newRoundedRect(grp, 0,0, width, height, radius )
	
	rect:setStrokeColor(1)
	rect.strokeWidth = 3
	
	local opt = {
		parent = grp,
		x = 0, 
		y = 0, 
		text = options.text or "NO TEXT ??",
		width = width,		
		align = "center", 
		fontSize = 35, 
		font = customFont  
	}
	
	if (colors) then 
		rect:setFillColor(unpack(colors))
	else 
		rect:setFillColor(getColorUnpacked("orange", "500"))
	end 

	local txt = display.newText(opt)

	grp.textField = txt 
	
	function grp:tap(event)

		if (self.handle) then 
			audio.play(self.handle)
		end 
	
		if (self.data.callback) then 			
			self.data.callback(self.data.params)
		end 
		
		if (self.data.scene) then
			local composer = require("composer")
			--print("change scene")
			composer.gotoScene(self.data.scene, self.data.params)		
		end 

		return true 
	end 
	
	grp:addEventListener("tap", grp)

	function grp:setText(txt)
		self.textField.text = txt 
	end 
	
	
	return grp 
	
	-- width 
	-- height 
	-- text 
	-- onClick 
end 


return ui 