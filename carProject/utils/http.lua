if (_corona) then
	return require('http')
end

-- load the http module
--local io = require("io")
local http = require("socket.http")
--local ltn12 = require("ltn12")
local json = require('utils.json')


function http.get(url, callback)
	local url = url or 'https://api.fixer.io/latest'
	local callback = callback or table.print

	local response = http.request(url)

	local ret = json.decode(response)
	callback(ret)
end


return http



