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
    local spriteNor = display.newSprite("player.png")
    local spriteSur = display.newSprite("player_surprise.png")

    spriteNor:setTouchEnabled(true) -- enable sprite touch
    spriteSur:setTouchEnabled(true)

    spriteNor:addTouchEventListener(function(event, x, y)
        -- event: began, moved, ended
        -- x, y: world coordinate
        if event == "began" then
            return true -- catch touch event, stop event dispatching
        end

        local touchInSprite = spriteNor:getCascadeBoundingBox():containsPoint(CCPoint(x, y))
        if event == "moved" then
            if touchInSprite then

            else

            end
        elseif event == "ended" then
            if touchInSprite then 
            	-- print("touch me")
                spriteNor:setVisible(false)
                spriteSur:setVisible(true)
            end

        else

        end
    end)

    spriteSur:addTouchEventListener(function(event, x, y)
        -- event: began, moved, ended
        -- x, y: world coordinate
        if event == "began" then
            return true -- catch touch event, stop event dispatching
        end

        local touchInSprite = spriteNor:getCascadeBoundingBox():containsPoint(CCPoint(x, y))
        if event == "moved" then
            if touchInSprite then

            else

            end
        elseif event == "ended" then
            if touchInSprite then 
                -- print("touch me")
                spriteSur:setVisible(false)
                spriteNor:setVisible(true)
            end

        else

        end
    end)

    spriteNor:setPosition(ccp(display.cx - 50, display.cy - 50)) 
    spriteSur:setPosition(ccp(display.cx - 50, display.cy - 50)) 
    spriteNor:setScale(0.65)
    spriteSur:setScale(0.65)

    self:addChild(spriteNor)
    self:addChild(spriteSur)

    spriteSur:setVisible(false)
    _sprite = spriteNor
end


function Player:onRelease()
end