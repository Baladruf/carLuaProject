local blue = {0.11764705882353,0.53333333333333,0.89803921568627}


local pre = {
  "in", "out", "inOut", "outIn"
}

local mode = {
  "Sine", "Quad", "Cubic", "Circ", "Back", "Elastic", "Bounce"
}

local start


local function remove(object)
    transition.to(object, {alpha = 0, onComplete=start})
end

function start(object)
  if (object) then
    object:removeSelf()
  end
  local name = pre[math.random(4)]..mode[math.random(7)]

  local ease = easing[name]

  if ease == nil then
    print(name.." does not exist ")
    return
  end

  local sq = display.newRect(0,halfH,50,50)
  sq:setFillColor(unpack(blue))
  transition.to(sq, {time=3000, x=halfW, transition=ease, onComplete=remove})
end

start()
