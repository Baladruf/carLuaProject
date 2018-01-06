--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:833cf515c939d6e01ac7f6003606799b:68da03ba41578ed7f9c593536d9a6079:6259b37065f43b4f17459ee59e5f382a$
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
            -- girlBody
            x=3,
            y=630,
            width=599,
            height=209,

        },
        {
            -- girlHead
            x=3,
            y=843,
            width=422,
            height=303,

        },
        {
            -- girlWheel1
            x=864,
            y=762,
            width=119,
            height=119,

        },
        {
            -- girlWheel2
            x=864,
            y=885,
            width=118,
            height=119,

        },
        {
            -- orcBody
            x=3,
            y=406,
            width=636,
            height=220,

        },
        {
            -- orcHead
            x=648,
            y=3,
            width=313,
            height=246,

        },
        {
            -- orcWheel
            x=673,
            y=762,
            width=187,
            height=187,

        },
        {
            -- orcWheel2
            x=673,
            y=953,
            width=187,
            height=187,

        },
        {
            -- truckBody
            x=3,
            y=3,
            width=641,
            height=399,

        },
        {
            -- truckHead
            x=648,
            y=253,
            width=300,
            height=261,

        },
        {
            -- truckWheel
            x=429,
            y=843,
            width=240,
            height=240,

        },
        {
            -- truckWheel2
            x=643,
            y=518,
            width=241,
            height=240,

        },
    },
    
    sheetContentWidth = 986,
    sheetContentHeight = 1149
}

SheetInfo.frameIndex =
{

    ["girlBody"] = 1,
    ["girlHead"] = 2,
    ["girlWheel1"] = 3,
    ["girlWheel2"] = 4,
    ["orcBody"] = 5,
    ["orcHead"] = 6,
    ["orcWheel"] = 7,
    ["orcWheel2"] = 8,
    ["truckBody"] = 9,
    ["truckHead"] = 10,
    ["truckWheel"] = 11,
    ["truckWheel2"] = 12,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
