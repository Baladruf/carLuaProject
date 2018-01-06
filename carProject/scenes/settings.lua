-- settings.lua 
local composer = require("composer")
local widget = require( "widget" )
local json = require("json")
local filename = system.pathForFile("assets/save/menuColor.json", system.ResourceDirectory)
local decode, pos, msg = json.decodeFile(filename)

local ui = require("scripts.ui")
local loc = require("scripts.loc")

local sliderList = {}
local squareList = {}

local function sliderListener( event )
    if event.target.square == "left" then
		squareList.left:setFillColor(sliderList[1].value / 100, sliderList[2].value / 100, sliderList[3].value / 100)
	else
		squareList.right:setFillColor(sliderList[4].value / 100, sliderList[5].value / 100, sliderList[6].value / 100)
	end
end

local function saveColor()
	local file = io.open(filename, "w+")
    file.write(file, json.encode({{sliderList[1].value / 100, sliderList[2].value / 100, sliderList[3].value / 100}, {sliderList[4].value / 100, sliderList[5].value / 100, sliderList[6].value / 100}}))
    io.close(file)
end

local scene = composer.newScene()
--local prefs 

local defaultPref = {
	lang = "fr",
	vibration = true 
}



local function goBack()
	--print("back")
	composer.gotoScene("scenes.menu")
end 

local function changeLanguage(params)

	print(" in save")
	for k,v in pairs(params) do 
		print(k..":"..v)
	end 

	loc:setLanguage(params.lang) 	
	
	for k,v in pairs(params) do 
		prefs[k] = v 
	end 
	
 	table.save(prefs, "preferences.json", system.DocumentsDirectory)



end 


local buts = {


	{
	width = 350, 
	height = 60, 	
	radius = 10,
	colors = {0.4,0.7, 0.9},
	text="English",
	--onClick=changeLanguage, 
	callback=changeLanguage,
	params = {lang = "en"}
	}, 
	{
	width = 350, 
	height = 60, 	
	radius = 10,
	colors = {0.4,0.7, 0.9},
	text="French",
	--onClick=changeLanguage, 
	callback=changeLanguage,
	params = {lang = "fr"}
}, 
{
	width = 350, 
	height = 60, 	
	radius = 10,
	colors = {0.4,0.7, 0.9},
	text="Save gradient",
	--onClick=goBack 
	callback=saveColor
},
	{
	width = 350, 
	height = 60, 	
	radius = 10,
	colors = {0.4,0.7, 0.9},
	text="Back",
	--onClick=goBack 
	callback=goBack
}
}

local sliderListOption = {
	{ x = -halfW / 1.5, y = -2 * halfH / 3, orientation = "horizontal", width = halfW / 2, value = 0, listener = sliderListener },
	{col = "r", square = "left"},
	{ x = -halfW / 1.5, y = -halfH / 3, orientation = "horizontal", width = halfW / 2, value = 0, listener = sliderListener },
	{col = "g", square = "left"},
	{ x = -halfW / 1.5, y = 0, orientation = "horizontal", width = halfW / 2, value = 0, listener = sliderListener },
	{col = "b", square = "left"},
	
	{ x = halfW / 1.5, y = -2 * halfH / 3, orientation = "horizontal", width = halfW / 2, value = 0, listener = sliderListener },
	{col = "r", square = "right"},
	{ x = halfW / 1.5, y = -halfH / 3, orientation = "horizontal", width = halfW / 2, value = 0, listener = sliderListener },
	{col = "g", square = "right"},
	{ x = halfW / 1.5, y = 0, orientation = "horizontal", width = halfW / 2, value = 0, listener = sliderListener },
	{col = "b", square = "right"}
}



function scene:create(event)

	prefs = table.load("preferences.json", system.DocumentsDirectory) or defaultPref

	loc:setLanguage(prefs.lang) 
	
	for k,v in pairs(defaultPref) do 
		prefs[k] = prefs[k] or v 
	end 
	
	local function onUpdate(pct )
		-- setVolume 
		print(pct)
	end 
	
	
	--local slider = ui:makeCursor({width = 400, height = 50, onUpdate = onUpdate})
	
	--slider.x = 200
	--slider.y = 100 
	
	-- print("vibration = "..pref.vibration)
	
	--local sliderB1 = widget.newSlider(
    
--)
	
	local grp = display.newGroup()
	grp.anchorChildren = false 
	
	scene.view:insert(grp)
	
	--grp:insert(sliderB1)
	squareList.left = display.newRect(grp, -2 * halfW / 3, halfH / 2, halfW / 3, halfH / 3)
	squareList.left:setFillColor(0, 0, 0)
	squareList.right = display.newRect(grp, 2 * halfW / 3, halfH / 2, halfW / 3, halfH / 3)
	squareList.right:setFillColor(0, 0, 0)
	
	for i = 1, table.getn(sliderListOption), 2 do 
		local slid = widget.newSlider(sliderListOption[i])
		slid.col = sliderListOption[i + 1].col
		slid.square = sliderListOption[i + 1].square
		grp:insert(slid)
		table.insert(sliderList, slid)
		--table.print(slid)
	end

	for k,v in ipairs(buts) do 
		local btn = ui:makeTextButton(v)
		grp:insert(btn)
		btn.x = 0
		btn.y = (-halfH / 2 ) + (k * (btn.height + 10))
	end 
	
	grp.x = halfW 
	grp.y = halfH 

end 

scene:addEventListener("create")


return scene 

