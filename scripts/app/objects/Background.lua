require "app/objects/extern"

--此处继承CCNode,因为需要维持这个表，但是用object的话需要retian/release
Background = class("Background", function()
return CCNode:create()
end)

Background.__index = Background

local _bgSpriteVec = {}

function Background:create()
	local ret = Background.new()
		ret:init()
	return ret
end

function Background:init()
    self:initBackground()
    self:initBtn()
end

function Background:initBackground()

    local index = 1
     do --早上课室
        local bg = display.newSprite("back_class_normal.png")
        bg:setVisible(false)
        bg:setPosition(ccp(display.cx, display.cy))
        self:addChild(bg)
        _bgSpriteVec[index] = bg
        index = index + 1
    end

    do --下午课室
        local bg = display.newSprite("back_class_sunset.png")
        bg:setVisible(false)
        bg:setPosition(ccp(display.cx, display.cy))
        self:addChild(bg)
        _bgSpriteVec[index] = bg
        index = index + 1
    end

    do --晚上房间
        local bg = display.newSprite("back_room_night.png")
        bg:setVisible(false)
        bg:setPosition(ccp(display.cx, display.cy))
        self:addChild(bg)
        _bgSpriteVec[index] = bg
        index = index + 1
    end

    do --早上房间
        local bg = display.newSprite("back_room_normal.png")
        bg:setVisible(false)
        bg:setPosition(ccp(display.cx, display.cy))
        self:addChild(bg)
        _bgSpriteVec[index] = bg
        index = index + 1
    end

    do --下午房间
        local bg = display.newSprite("back_room_sunset.png")
        bg:setVisible(false)
        bg:setPosition(ccp(display.cx, display.cy))
        self:addChild(bg)
        _bgSpriteVec[index] = bg
        index = index + 1
    end

    do --自定义房间
        local bg =display.newLayer()
        bg:setVisible(false)
        bg:setPosition(ccp(display.cx, display.cy))
        self:addChild(bg)
        _bgSpriteVec[index] = bg
        index = index + 1



        do --window
            local openVisible = true
            local closeVisible = false

            local curtainOpen = display.newSprite("curtain_open.png")
            bg:addChild(curtainOpen, 2)
            curtainOpen:setPosition(ccp(display.cx - 225, display.cy - 150)) 
            curtainOpen:setScale(0.8)
            curtainOpen:setVisible(openVisible)

            local curtainClose = display.newSprite("curtain_close.png")
            bg:addChild(curtainClose, 2)
            curtainClose:setPosition(ccp(display.cx - 225, display.cy - 250)) 
            curtainClose:setScale(0.8)
            curtainClose:setVisible(closeVisible)

            local sprite = display.newSprite("window.png")
            bg:addChild(sprite)
            sprite:setPosition(ccp(display.cx - 200, display.cy - 250)) 
            sprite:setScale(0.8)

            sprite:setTouchEnabled(true) -- enable sprite touch
            sprite:addTouchEventListener(function(event, x, y)
 
            if event == "began" then

                return true -- catch touch event, stop event dispatching
            end

            local touchInSprite = sprite:getCascadeBoundingBox():containsPoint(CCPoint(x, y))
            if event == "moved" then

            elseif event == "ended" then

            openVisible, closeVisible = not openVisible, openVisible

            curtainOpen:setVisible(openVisible)
            curtainClose:setVisible(closeVisible)
            else

            end
        end)   
        end

        do --curtain open

        end

        do --curtain close

        end        
    end
   
end

function Background:initBtn()
        
        local index = 1
        local bgVec = _bgSpriteVec
        local size = table.getn(bgVec)
        index = math.random(1, size)
        index = 6 --test
        bgVec[index]:setVisible(true)

        local sprite = display.newSprite("refresh.png")
        self:addChild(sprite)

        sprite:setPosition(ccp(display.left + 50, display.top - 50))
        sprite:setTouchEnabled(true) -- enable sprite touch
        sprite:addTouchEventListener(function(event, x, y)
 
            if event == "began" then
                sprite:setScale(0.9)
                return true -- catch touch event, stop event dispatching
            end

            local touchInSprite = sprite:getCascadeBoundingBox():containsPoint(CCPoint(x, y))
            if event == "moved" then

            elseif event == "ended" then
                local bgPre = bgVec[index]
                bgPre:setVisible(false)
                index = index + 1
                if index == size + 1 then
                    index = 1
                end
                local bgNow = bgVec[index]
                bgNow:setVisible(true) 

                sprite:setScale(1.0)
            else
                sprite:setScale(1.0) 
            end
        end)   
end


function Background:onRelease()
end