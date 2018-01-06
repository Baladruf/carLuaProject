
local composer = require( "composer" )
local physics = require("physics")
local networkManager = require("scripts.networkmanager")
local scene = composer.newScene()

local elements
 
function scene:create( event )

    local sceneGroup = self.view
    elements = {}
end

local function makeChar ()

    local sheetOptions = require("assets.chars.templerun")

    local sequenceData = {

        {name="dead", start =1, count= 10, time=1000, loopCount=1},
        {name="idle", start =11, count= 10, time=1000, loopCount=0},
        {name="jump", start =21, count= 10, time=1000, loopCount=1},
        {name="run", start =31, count= 10, time=1000, loopCount=0}
    }


    local sheet = graphics.newImageSheet("assets/chars/templerun.png", sheetOptions:getSheet()) 

    -- print(sheet)

    local sprite = display.newSprite(sheet, sequenceData)

    sprite.x = halfW 
    sprite.y = halfH
    sprite.xScale = 0.35 
    sprite.yScale = 0.35 
    
    sprite.startY = sprite.y 
    sprite.startX = sprite.x

    sprite:setSequence("idle")


    function sprite:enterFrame(event)

        --print("---------------")
        --for k,v in pairs(event) do 
        --  print(k..":"..tostring(v))
        --end 

        --if (event.phase == "loop") then 
        --  event.target:pause()
        --end 
        if (math.abs(self.fx or 0) > 0) or (math.abs(self.fy or 0) > 0) then  
            self:applyForce(self.fx, self,fy, self.x, self.y)
        end 

    end 

    --sprite.jumpCount = 0 
    
    function sprite:jump()
        --sprite.jumpCount = sprite.jumpCount + 1 
        --self.isJumping = true 
        --if (sprite.jumpCount > 2) then 
        --  return 
        --end 
        self:setSequence("jump")
        self:play()
        self:applyLinearImpulse(0, -3, self.x,self.y)
    end 

    function sprite:run(right, on)
        --sprite.jumpCount = sprite.jumpCount + 1 
        --self.isJumping = true 
        --if (sprite.jumpCount > 2) then 
        --  return 
        --end 
        local mult = 1
        if (not right) then 
            mult = -1 
        end 

        if (on == false) then 
            mult = 0 
        end 

        self.fy = 0 
        self.fx = mult


        
        self.xScale = mult*math.abs(self.xScale) 


        
        self:setSequence("run")
        self:play()

    end 

    function sprite:key(event)

        print("---------------")
        for k,v in pairs(event) do 
            print(k..":"..tostring(v))
        end 
        
        if (event.keyName == "space") and (event.phase == "up") then 
            self:jump()
        end 


        if (event.keyName == "down") then
            self.down = (event.phase == "down")
            --self:run(false, (event.phase == "down"))
        end 


        if (event.keyName == "left") then
            self:run(false, (event.phase == "down"))
        end 

        if (event.keyName == "right") then 
            self:run(true, (event.phase == "down"))
        end 
        
    end 
    

    Runtime:addEventListener("enterFrame", sprite)
    Runtime:addEventListener("key", sprite)
    sprite:setSequence("idle")
    sprite:play()   
    return sprite
    
end 

local function makeCar(id)
    id = id or 1
    local names = {"truck","orc", "girl"}
    name = names[id] or "truck"

    local sheetOptions = require("assets.gameassets.cars.cars")
    local sheet = graphics.newImageSheet("assets/gameassets/cars/cars.png", sheetOptions:getSheet())


    local grp = display.newGroup()

    local body = display.newImage( grp, sheet, sheetOptions:getFrameIndex(name.."Body"), 0, 0  )
    local head = display.newImage( grp, sheet, sheetOptions:getFrameIndex(name.."Head"), 0, -body.height/2  )
    local wheel1 = display.newImage( grp, sheet, sheetOptions:getFrameIndex(name.."Wheel"), -body.width/2, body.height/2  )
    local wheel2 = display.newImage( grp, sheet, sheetOptions:getFrameIndex(name.."Wheel2"), body.width/2, body.height/2  )

    grp.x = halfW
    grp.y = halfH
    return grp 
end 

 
 
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then

        print("in test")
        physics.start(false) -- true  : disables sleep mode which allows to change gravity dynamically 
        -- physics.setDrawMode("hybrid")

        physics.setGravity(0, 9.8)

        local height = 20

        local floor = display.newRect(halfW, screenH - height, screenW, height )
        floor:setFillColor(1)
        physics.addBody(floor, "static") -- "dynamic", "kinematic"


        local wall = display.newRect(screenW - 10 , halfH, 20, screenH )
        wall:setFillColor(1)
        physics.addBody(wall, "static") -- "dynamic", "kinematic"
        
        local wall2 = display.newRect(10 , halfH, 20, screenH )
        wall2:setFillColor(1)
        physics.addBody(wall2, "static") -- "dynamic", "kinematic"
        
        --[[

        local options = {
            filename = "assets/particles/spark.png",
            baseDir = system.ResourceDirectory, 
            imageRadius = 20, 
            radius = 10, 
            destroyByAge = true, 
            maxCount = 5000,
            blandMode= "multiply"
        }


        local particleSystem = physics.newParticleSystem(options)


        local x, y 
        local touchOn = false 
        local r,g,b 

        local function onEnterFrame() 
            if (touchOn) then 
                particleSystem:createParticle({
                    x = x, 
                    y = y,
                    velocityX = 5, 
                    velocityY = 0, 
                    color = { r, g, b},
                    flags = {"powder" , "colorMixing"}
                })
            end 
         end 


         Runtime:addEventListener("enterFrame", onEnterFrame)

        local mask = display.newRect(halfW, halfH, screenW, screenH)
        mask.fill = {0,0,0,0.01}


         function mask:touch(event)

            print(event.phase)

            if (event.phase == "began") then 
                touchOn = true 
                r = 0.3 + math.random()*0.5
                g = 0.3 + math.random()*0.5 
                b = 0.3 + math.random()*0.5 
            end 


            if (event.phase == "ended") then 
                touchOn = false 
            end 

            x = event.x 
            y = event.y 

        end 


        mask:addEventListener("touch", mask)



        local function accel_listener(event)
        
            table.print(event)

            --event.xRaw 
            --event.yRaw 
            --event.zRaw
            --event.xGravity 
            --event.yGravity 
            --event.zGravity 

            physics.setGravity(event.xGravity, event.yGravity ) 

        end 


        local joystick = display.newCircle(halfW, halfH, 40)
        joystick.fill = {1,0,0, 0.3}

        function joystick:touch(event)

            --(event)

            joystick.x= event.x 
            joystick.y = event.y 

            event.xGravity = 10*(event.x - halfW) / halfW  
            event.yGravity = -10*(event.y- halfH) / halfH

            accel_listener(event)


        end 

        joystick:addEventListener("touch", joystick)        
        -- Runtime:addEventListener("accelerometer", accel_listener)


        ]]

        --[[

        local function createCrate()
            local img = display.newImage("assets/physics/crate.png", screenW*0.25 + math.random(halfW), 100)
            physics.addBody(img)
        end 

        local function createBall(event)
            local img = display.newImage("assets/physics/coconut.png", event.x, event.y)
            physics.addBody(img, "dynamic", {radius = img.width/2})
        end 

        --Runtime:addEventListener("tap", createBall)



        ]]

        -- notifications.getFrameIndexetDeviceToken() !"lkjdljqlkjdlkjqdlkjsdlkjsdlksqd"


        -- loop sur 2016 
        -- prendre la valeur des deux monnaies au 15 de chaque mois
        -- tracer deux lignes qui montrent l'historique de ces valeurs 

        -- display.newLine(x1, y1, x2, y2, x3, y3..)  

        networkManager.get("https://api.fixer.io/2000-01-03?symbols=USD,GBP", function(data) print(data) end)









        
        makeCar()

        local rect = display.newRect(halfW, screenH*.25, 80, 80)
        physics.addBody(rect, "static")

        local prev = rect 

        for i=1,10 do 
            local r = display.newRect(halfW + i*40, screenH*.25, 35, 5)
            physics.addBody(r)
            local ropeJoint = physics.newJoint("rope", prev, r, 15, 0, -15, 0)
            ropeJoint.maxLength = 15
            prev = r 
        end 


        --local touchJoint = physics.newJoint("touch", prev, prev.x, prev.y)

        --function prev:touch(event)
         --   touchJoint:setTarget(event.x, event.y)
        --end 


        --Runtime:addEventListener("touch", prev)



        -- distance 
        --local rect2 = display.newRect(screenW*0.75, screenH*.25, 80, 80)
        --physics.addBody(rect2, "dynamic")
        --local distanceJoint = physics.newJoint("distance", rect, rect2, rect.x, rect.y, rect2.x, rect2.y)
        --distanceJoint.dampingRatio = 0
        --distanceJoint.frequencey = 10

        --local rect2 = display.newRect(screenW*0.75, screenH*.25, 80, 80)
        --physics.addBody(rect2, "dynamic")
        --local ropeJoint = physics.newJoint("rope", rect, rect2) --, rect.x, rect.y, rect2.x, rect2.y)
        --ropeJoint.maxLength = screenW*0.4
        --ropeJoint.dampingRatio = 0
        --ropeJoint.frequencey = 100






        -- pivot joint : axe de rotation 
        --local rect2 = display.newRect(screenW*0.6, screenH*.25, screenW*0.2, 20)
        --physics.addBody(rect2, "dynamic")
        -- local pivotJoint = physics.newJoint("pivot", rect, rect2, rect.x + 3*rect.width, rect.y)
        -- pivotJoint.isLimitEnabled = true 
        -- pivotJoint:setRotationLimits( -45, 45 )
        -- moteur 
        --pivotJoint.isMotorEnabled = true 
        --pivotJoint.motorSpeed = 100 
        --pivotJoint.maxMotorTorque = 10000

        --local rect2 = display.newRect(halfW, screenH*.35, 80, 80)
        --physics.addBody(rect2)
        --local pistonJoint = physics.newJoint("piston", rect, rect2, rect.x, rect.y, 1,-1 )

        --pistonJoint.isLimitEnabled = true 
        --pistonJoint:setLimits(-200, 800)

        --pistonJoint.isMotorEnabled = true 
        --pistonJoint.motorSpeed = 100
        --pistonJoint.maxMotorForce = 500








        --[[

        local char = makeChar()
        physics.addBody(char, "dynamic", {

            filter = { categoryBits= 1, maskBits = 0 },

            box = {
                halfWidth = char.contentWidth/2, 
                halfHeight = char.contentHeight/2, 
                x=0, 
                y=0
        }})


        -- physics.setTimeScale()
        -- physics.getTimeScale()


        



        local function collisionListener(event)

            if (event.other.isPlatform) and (event.contact) then 
                table.print(event)
                
                event.contact.isEnabled = false

                -- event.contact.bounce 
                -- event.contact.friction 


            end 


        end 



        char:addEventListener("preCollision", collisionListener)


        local obj = display.newRect(halfW, screenH - 250, 500, 50)
        physics.addBody(obj, "static")
        obj.isPlatform = true 

        ]]
        
        --, {
        --    chain = {-250, -50, -200, -40, 0, -50, 50, 0, 200, -10, 250, -50}, 
        --})
        
    

        --[[

        local _outline = graphics.newOutline(1, "assets/puzzle/piece1.png", system.ResourceDirectory)

        local piece= display.newImage("assets/puzzle/piece1.png")
        piece.x = piece.width/2 
        piece.y = 0
        physics.addBody(piece, "dynamic", {outline = _outline })
        ]]


        -- char.isFixedRotation = true

        -- char.isAwake 
        -- char.isSleepingAllowed 
        -- char.gravityScale 
        -- angularVelocity 

        -- char.angularDamping = 10
        -- char.linearDamping = 10 

        -- char.angularVelocity = 10

        -- vx,vy = char:getLinearVelocity()
        -- char:setLinearVelocity(vx,vy)

        -- char:applyTorque(t)
        -- char:applyAngularImpulse(t)


        -- char:resetMassData()



    elseif ( phase == "did" ) then
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    
    local phase = event.phase
    if ( phase == "will" ) then 





    elseif ( phase == "did" ) then





    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
	elements = nil  
end
 
 
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
return scene