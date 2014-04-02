require "app/objects/extern"

--此处继承CCNode,因为需要维持这个表，但是用object的话需要retian/release
Player = class("Player", function()
return CCNode:create()
end)

Player.__index = Player

local _sprite = nil

function Player:create()
	local ret = Player.new()
		ret:init()
	return ret
end

function Player:init()
    local sprite = display.newSprite("player.png")
    sprite:setTouchEnabled(true) -- enable sprite touch
    sprite:addTouchEventListener(function(event, x, y)
        -- event: began, moved, ended
        -- x, y: world coordinate
        if event == "began" then
            sprite:setOpacity(128)
            return true -- catch touch event, stop event dispatching
        end

        local touchInSprite = sprite:getCascadeBoundingBox():containsPoint(CCPoint(x, y))
        if event == "moved" then
            if touchInSprite then
                sprite:setOpacity(128)
            else
                sprite:setOpacity(255)
            end
        elseif event == "ended" then
            if touchInSprite then 
            	print("touch me")

            end
            sprite:setOpacity(255)
        else
            sprite:setOpacity(255)
        end
    end)

    sprite:setPosition(ccp(display.cx - 50, display.cy)) 
    sprite:setScale(0.8)

    self:addChild(sprite)

    _sprite = sprite
end


function Player:onRelease()
end