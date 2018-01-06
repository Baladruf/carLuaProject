-- tools.lua

local json = require("json")


local function loadJson(path, directory)

	directory = directory or system.DocumentsDirectory

	local realPath = system.pathForFile(path, directory)
	if not realPath then 
		error("no such file : "..path)
	end 
	
	local file, err = io.open(realPath, "r") -- "w"
	
	if not file then 
		-- error(err)
		return nil
	else 
		local data = file:read("*a")

		if (data) then 
			return json.decode(data)
		end 
	end 

end

table.load = loadJson 


local function saveJson(data, path, directory)

	directory = directory or system.DocumentsDirectory

	local realPath = system.pathForFile(path, directory)
	
	local file, err = io.open(realPath, "w+") 
	if not file then 
		print(err)
	else 
		file:write(json.prettify(json.encode(data)))	
		io.close(file)
	end 
end


table.save = saveJson 