-- deplayprint.lua 

-- explicit version 
local function deplayprint1(message)
	
	local function printMessage()
		print(message)
	end 

	timer.performWithDelay(1000, printMessage)
end 


-- inline version 
local function deplayprint2(message)
	timer.performWithDelay(2000, function() print(message) end)
end 

local function deplayprint3(message)

	local function printMessage(event)
		print(event.source.message)
	end 

	local t = timer.performWithDelay(3000, printMessage)
	t.message = message 

end 

deplayprint3(3)
deplayprint2(2)
deplayprint1(1)
