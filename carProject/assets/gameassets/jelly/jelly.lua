--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:24d7df472cc4743bf9a663f64ad93520:1936ba417c9e7f0ee5c12019d8afe403:a751281f4d37f761157129eca061fe14$
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
            -- Face1
            x=614,
            y=553,
            width=258,
            height=93,

        },
        {
            -- Face2
            x=341,
            y=642,
            width=258,
            height=72,

        },
        {
            -- Face3
            x=341,
            y=718,
            width=258,
            height=72,

        },
        {
            -- Face4
            x=341,
            y=559,
            width=258,
            height=79,

        },
        {
            -- Face5
            x=3,
            y=741,
            width=256,
            height=48,

        },
        {
            -- Face6
            x=603,
            y=650,
            width=128,
            height=128,

        },
        {
            -- JellyS1
            x=305,
            y=3,
            width=311,
            height=270,

        },
        {
            -- JellyS2
            x=3,
            y=3,
            width=298,
            height=301,

        },
        {
            -- JellyS3
            x=620,
            y=3,
            width=297,
            height=252,

        },
        {
            -- JellyS4
            x=313,
            y=277,
            width=297,
            height=278,

        },
        {
            -- JellyS5
            x=3,
            y=308,
            width=306,
            height=275,

        },
        {
            -- JellyS6
            x=614,
            y=277,
            width=297,
            height=272,

        },
        {
            -- Shadow
            x=3,
            y=587,
            width=334,
            height=150,

        },
    },
    
    sheetContentWidth = 920,
    sheetContentHeight = 793
}

SheetInfo.frameIndex =
{

    ["Face1"] = 1,
    ["Face2"] = 2,
    ["Face3"] = 3,
    ["Face4"] = 4,
    ["Face5"] = 5,
    ["Face6"] = 6,
    ["JellyS1"] = 7,
    ["JellyS2"] = 8,
    ["JellyS3"] = 9,
    ["JellyS4"] = 10,
    ["JellyS5"] = 11,
    ["JellyS6"] = 12,
    ["Shadow"] = 13,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
