local circle = display.newCircle(halfW, 0, 10)
circle.v = 4
local lasttime
local currenttime

local update = function( event )

    currenttime = event.time/1000

    if lasttime == nil then
        lasttime = currenttime
    end

    local diff = currenttime - lasttime
    lasttime = currenttime

    circle.y = circle.y + circle.v * diff
    circle.v = circle.v + 10*diff

    if (circle.y > screenH - 10) then
        circle.y = screenH - 10
        circle.v = -1* circle.v*0.75
    end

end
Runtime:addEventListener( "enterFrame", update )
