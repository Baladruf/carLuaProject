
local M = {}



local function helloWorld()

	print('in hello world')

	-- programme hello world basique
	local options =
	{
		text = "Coucou !",
		x = halfW,
		y = halfH,
		fontSize = 50
	}

	local textobject = display.newText(options)
	textobject:setFillColor(1,0,0)

end 


local function remote()
	print('in remote')

	local function imageListener(event)

		print("update : ")

		for k,v in pairs(event.response) do 
			print(k..":"..tostring(v))
		end 

		if (event.isError) then 
			print("ouch, "..event.response.filename.." could not be loaded")
			return 
		end 

		event.target.alpha = 0.5

	end

	display.loadRemoteImage( "https://loremflickr.com/320/240/kitten", "GET", imageListener, "kitten", halfW, halfH)
end 


local pages = {remote, helloWorld}


function M:showPage(n)


	n = n or 1

	local f = pages[n]

	if (f) then 
		f()
	else 
		print("no function")
	end 


end 


return M
