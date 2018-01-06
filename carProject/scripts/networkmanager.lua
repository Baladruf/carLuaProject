--network manager 
local json = require("json")

local networkManager = {}


function networkManager.get(url, callback, error_callback) 


	--print(callback)


	local baseurl = url:sub(1,(url:find('%?') or 0)-1)

	baseurl = baseurl:gsub("%.","_")
	baseurl = baseurl:gsub("%/","_")
	baseurl = baseurl:gsub("%:","_")

	print(baseurl)

	local function listener(event) 

		--table.print(event)

		-- get 


		if (event.phase == "ended") then 

			if (event.status < 300 ) then 
				print("in networkmanager ", event.response)
 				if (callback) then
 					local data = json.decode(event.response)
 					if (data) then 
 						table.save(data, baseurl) 	
						table.print(data)
						callback(event.response)
					end 
				end 

			else
				print("There was an error")
				-- error_callback()
			end 
		end 

	end 


	local data = table.load(baseurl)
	if (data) then 
		callback(data)
		return 
	end 

	network.request(url, "GET", listener)

end 


return networkManager