
luaunit = require('../utils/luaunit')


ex2 = require('../course/module1/ex2')

values = {"nil", "boolean", "number", "string","table","function"}
variables = {a,b,c,d,e,f}


values2 = {"nil", "nil", "number", "string","table","function"}
variables = {a,b,c,d,e,f}


print(ex2)

function testAddPositive()
    luaunit.assertEquals(ex2(values,variables),false)
    luaunit.assertEquals(ex2(values2,variables),false)
end

function testAddZero()

end



os.exit( luaunit.LuaUnit.run() )
