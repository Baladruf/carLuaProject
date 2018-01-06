
local blue1 = {0.11764705882353,0.53333333333333,0.89803921568627}
local blue2 = {0.25882352941176,0.64705882352941,0.96078431372549}

local circle0 = display.newCircle(halfW, halfH, halfH/2*1.1)
circle0:setFillColor(unpack(blue2))

local circle = display.newCircle(halfW, halfH, halfH/2)

local hand = display.newRect(0,0,10,halfH/2)
hand:setFillColor(unpack(blue1))
hand.anchorY = 0.95

local hand2 = display.newRect(0,0,20, halfH/4)
hand2:setFillColor(unpack(blue1))
hand2.anchorY = 0.95

hand.x, hand2.x = halfW, halfW
hand.y, hand2.y = halfH, halfH

hand.rotation = 40
hand2.rotation = 135
