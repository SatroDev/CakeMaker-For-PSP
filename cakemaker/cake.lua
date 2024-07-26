local json = require('cakemaker.core.json')


cake = {}
game = {}

function cake.toHex(num)
    local hexstr = '0123456789ABCDEF'
    local s = ''
    while num > 0 do
        local mod = math.fmod(num, 16)
        s = string.sub(hexstr, mod+1, mod+1) .. s
        num = math.floor(num / 16)
    end
    if s == '' then s = '0' end
    return "0x"..s
end

function cake.load_scene(path)
    game = {}
    collectgarbage("collect")
    local file = io.open(path, "r")
    game = json:decode(file:read("*all"))
    file:close()
    cake.load()
end

-- LOAD RESOURCE
function cake.load()
    game.bgcolor = color.new(255, 127, 80)

    game.camera = {
        x = 0,
        y = 0
    }

    game["behaviors"] = {
        entity=cake.entity,
        controlPad=cake.controlPad,
        obstacle=cake.obstacle,
        camera=cake.selfCamera
    }
    
    local list_animations = game["animations"]
    game.cache_animations={}

    for i_animation=1, #list_animations do
        local list_frames = list_animations[i_animation]["frames"]
        game.cache_animations[list_animations[i_animation].name] = i_animation 
        for i_frames=1, #list_frames do
            local frame = list_frames[i_frames]
            list_frames[i_frames] = image.load(frame) or image.load("cakemaker/notfound.png")
        end
    end

    for i_obj=1, #game["objects"] do
        game["objects"][i_obj]["fliphr"] = false
        game["objects"][i_obj]["flipvr"] = false
    end

    -- sounds
    local sounds = game["sounds"]
    if #sounds > 0 then
        for isound=1, #sounds do
            sounds[isound].res = sound.load(sounds[isound]["res"])
        end
    end
end

function cake.get(name, propierty)    
    local self
        for i=1, #game["objects"] do
            if game["objects"][i]["name"] == name then
                self = game["objects"][i][propierty]
                break
            end
        end
    return self
end


function cake.get_all(name)
    local self
    for i=1, #game["objects"] do
        if game["objects"][i]["name"] == name then
           self = game["objects"][i]
           break 
        end
    end
    return self
end

function cake.set(name, propierty, equal)
    for i=1, #game["objects"] do
        if game["objects"][i]["name"] == name then
            game["objects"][i][propierty] = equal
            break
        end
    end
end

function cake.flipv(name)
    local animation = cake.get(name, "animation")
    local frames = game["animations"][game.cache_animations[animation]]["frames"]
    for f=1, #frames do
        image.flipv(frames[f])
    end
end

function cake.fliph(name)
    cake.set(name, "fliph", true)
end


-- RENDER AND UPDATE RESOURCE

function cake.obstacle(obj)
    if obj.obstacle == nil then
        obj.obstacle = true
    end
end

function cake.entity(obj)
    obj.inCollision = (obj.inCollision ~= nil) and obj.inCollisio or false

    obj.top = false
    obj.bottom = false
    obj.left = false
    obj.right = false

    local objects = game["objects"]
    for iObj=1, #objects do
        if objects[iObj].name ~= obj.name then
            local obj2 = objects[iObj]

            local x = obj.x + obj.w >= obj2.x and obj.x < obj2.x + obj2.w
            local y = obj.y + obj.h >= obj2.y and obj.y < obj2.y + obj2.h

            -- PLAYER CENTER
            local PlayerCenterX = obj.x + obj.w / 2
            local PlayerCenterY = obj.y + obj.h / 2

            -- Obstacle Center
            local ObstacleCenterX = obj2.x + obj2.w / 2
            local ObstacleCenterY = obj2.y + obj2.h / 2

            local DistanceX = PlayerCenterX - ObstacleCenterX
            local DistanceY = PlayerCenterY - ObstacleCenterY

            local MinXDistance = obj.w / 2 + obj2.w / 2
            local MinYDistance = obj.h / 2 + obj2.h / 2

            local DepthX = DistanceX > 0 and MinXDistance - DistanceX or -MinXDistance - DistanceX
            local DepthY = DistanceY > 0 and MinYDistance - DistanceY or -MinYDistance - DistanceY

            if x and y and obj2.obstacle == true then
                obj.inCollision = true
                if DepthX ~= 0 and DepthY ~= 0 then
                    if math.abs(DepthX) < math.abs(DepthY) then
                        if DepthX >= 0 then
                            obj.x = obj2.x + obj2.w
                            obj.left = true
                        else
                            obj.x = obj2.x - obj.w
                            obj.right = true
                        end
                    else
                        if DepthY > 0 then
                            obj.y = obj2.y + obj2.h
                            obj.top = true
                        else
                            obj.y = obj2.y - obj.h
                            obj.bottom = true
                        end
                    end
                end
            end
        end
    end
end

function cake.play(name)
    local sounds = game["sounds"]
    for i=1, #sounds do
        if sounds[i]["name"] == name then
            sound.play(sounds[i]["res"])
            break
        end
    end
end

function cake.selfCamera(obj)
    game.camera.x = obj.x - 480 / 2 + obj.w / 2
    game.camera.y = obj.y - 272 / 2 + obj.h / 2
    obj.isCamera = true
end

function cake.controlPad(obj)
    local InputX = false
    local InputY = false

    if buttons.held.left then
        InputX = true
        obj.VelocityX -= (obj.VelocityX > obj.MaxVelocityX * -1) and obj.AccelerationX or 0
    elseif buttons.held.right then
        InputX = true
        obj.VelocityX += (obj.VelocityX < obj.MaxVelocityX) and obj.AccelerationX or 0
    end

    if buttons.held.up then
        InputY = true
        obj.VelocityY -= (obj.VelocityY > obj.MaxVelocityY * -1) and obj.AccelerationY or 0
    elseif buttons.held.down then
        InputY = true
        obj.VelocityY += (obj.VelocityY < obj.MaxVelocityY) and obj.AccelerationY or 0
    end

    if InputX == false then
        if obj.VelocityX < 0 then
            if obj.VelocityX + obj.AccelerationX > 0 then
                obj.VelocityX = 0
            else
                obj.VelocityX += obj.DecelerationX
            end
        else
            if obj.VelocityX - obj.AccelerationX < 0 then
                obj.VelocityX = 0
            else
                obj.VelocityX -= obj.DecelerationX
            end
        end
    end

    if InputY == false then
        if obj.VelocityY < 0 then
            if obj.VelocityY + obj.AccelerationY > 0 then
                obj.VelocityY = 0
            else
                obj.VelocityY += obj.DecelerationY
            end
        else
            if obj.VelocityY - obj.AccelerationY < 0 then
                obj.VelocityY = 0
            else
                obj.VelocityY -= obj.DecelerationY
            end
        end
    end

    if obj.right == true then
        if obj.VelocityX > 0 then
            obj.VelocityX = 0
        end
    end

    if obj.left == true then
        if obj.VelocityX < 0 then
            obj.VelocityX = 0
        end
    end

    if obj.bottom == true then
        if obj.VelocityY > 0 then
            obj.VelocityY = 0
        end
    end

    if obj.top == true then
        if obj.VelocityY < 0 then
            obj.VelocityY = 0
        end
    end

    obj.x += obj.VelocityX
    obj.y += obj.VelocityY

end
function cake.render()
    local list_objects = game["objects"]

    --screen.print(100, 100, tostring(cake.delta))

    for i_objects=1, #list_objects do
        local obj = list_objects[i_objects]
        local animation = game["animations"][game.cache_animations[obj.animation]]
        local list_frames = animation["frames"]
        
        obj.time = obj.time or 0
        obj.speed = obj.speed or 0
        obj.frame = obj.frame or 1
        obj.angle = obj.angle or 0
        obj.rotation = obj.rotation or 0

        if #obj.behaviors > 0 then
            for behavior=1, #obj.behaviors do
                local behavior_function = game["behaviors"][obj.behaviors[behavior]]
                if behavior_function then
                    behavior_function(obj)
                end
            end 
        end

        local frame = animation["frames"][obj.frame]

        obj.fliph = (obj.fliph ~= nil) and obj.fliph or false
        if obj.fliph == true and obj.fliphr == false then
            image.fliph(frame)
            obj.fliphr = true
            obj.angle = 0
            image.rotate(frame, 0)
        end

        if obj.fliph == false and obj.fliphr == true then
            image.fliph(frame)
            obj.fliphr = false
        end

        obj.flipv = (obj.flipv ~= nil) and obj.flipv or false

        obj.x = obj.x or 0
        obj.y = obj.y or 0
        
        if obj.speed > 0 then
            if obj.time < obj.speed then
                obj.time += 1 + cake.delta
            else
                obj.time = 0
                obj.frame += 1
            end
        end

        if obj.frame > #list_frames then
            obj.frame = 1
        end

        if obj.visible ~= nil then
            obj.visible = obj.visible
        else
            obj.visible = true
        end

        image.resize(
            frame,
            obj.w or 32,
            obj.h or 32
        )

        if obj.center == true then
            image.center(frame)
        end

        image.rotate(
            frame,
            obj.angle
        )
        obj.angle += obj.rotation

        local inScreenX = obj.x - game.camera.x + obj.w > 0 and obj.x - game.camera.x < 480 
        local inScreenY = obj.y - game.camera.y + obj.h > 0 and obj.y - game.camera.y < 272 
        if obj.visible == true and inScreenX  == true and inScreenY then
                
                image.blit(
                    frame,
                    obj.x - game.camera.x or 0,
                    obj.y - game.camera.y or 0
                )
        end

    end
end

cake.delta = os.clock()
function cake.update()
    local lastTime = os.clock()

    screen.clear(game.bgcolor)
    cake.render()
    
    local currentTime = os.clock()

    cake.delta = currentTime - lastTime
    
end