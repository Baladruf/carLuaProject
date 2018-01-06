
--[[

Goal : Debug a function that takes a list of variables and a list of types, and checks that all the variables have the expected types

]]


local a
local c = 42
local d = "hello"
local e = {}

local f = function()
	c = "42"
	local b = (a == nil)
end

values = {"nil", "boolean", "number", "string","table","function"}
variables = {a,b,c,d,e,f}


function checkAllValues(variables, values)
	local allFound = true
	for key, value in ipairs(variables) do
		allFound = allFound and (value == values[key])
	end

	return allFound
end


return checkAllValues




