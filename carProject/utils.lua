
local pprint = require('utils.pprint')
table.print = pprint

function _log(message, emittor)
  emittor = emittor or "NONE"
  print("["..emittor.."]"..tostring(message))
end

if _corona then

	local json = require('json')


	local function loadJson(filename, dir)
		dir = dir or system.DocumentsDirectory
		local path = system.pathForFile( filename, dir)
		local contents = ""
		local myTable = {}
		local file = io.open( path, "r" )
		if file then
			--print("trying to read ", filename)
			-- read all contents of file into a string
			local contents = file:read( "*a" )
			myTable = json.decode(contents);
			io.close( file )
			--print("Loaded file")
			return myTable
		end
		print(filename, "file not found")
		return nil
	end

	table.loadJson = loadJson
end
