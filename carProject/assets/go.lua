--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:b57953038f87dc50f6a7e6a1d407de9e:bdb270aada7d2d13d52d698729a41eb0:03e9806833787f97b5d85f430016be93$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- 1
            x=223,
            y=1,
            width=46,
            height=136,

            sourceX = 126,
            sourceY = 32,
            sourceWidth = 300,
            sourceHeight = 200
        },
        {
            -- 2
            x=271,
            y=1,
            width=82,
            height=134,

            sourceX = 111,
            sourceY = 36,
            sourceWidth = 300,
            sourceHeight = 200
        },
        {
            -- 3
            x=355,
            y=1,
            width=82,
            height=134,

            sourceX = 108,
            sourceY = 38,
            sourceWidth = 300,
            sourceHeight = 200
        },
        {
            -- go
            x=1,
            y=1,
            width=220,
            height=138,

            sourceX = 42,
            sourceY = 31,
            sourceWidth = 300,
            sourceHeight = 200
        },
    },
    
    sheetContentWidth = 438,
    sheetContentHeight = 140
}

SheetInfo.frameIndex =
{

    ["1"] = 1,
    ["2"] = 2,
    ["3"] = 3,
    ["go"] = 4,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
