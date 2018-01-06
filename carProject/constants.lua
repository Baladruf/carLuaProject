
local pfc = {
    ["Mac OS X"] = "osx"; --(Corona Simulator on Mac)
    ["Win"] = "win"; --(Corona Simulator on Windows)
    ["iPhone OS"] = "ios"; --(all iOS devices and Xcode Simulator)
    ["Android"] = "android"; --(all Android devices)
}

if (system) then
	platformName = system.getInfo( "platformName" )
else
	platformName = "Win"
end

platformCode = pfc[platformName] or "none"

if (display) then
	screenW, screenH = display.contentWidth, display.contentHeight
	halfW, halfH = display.contentWidth*0.5, display.contentHeight*.5
end
