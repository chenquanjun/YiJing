require "app/objects/Background"

local GameScene = class("GameScene", function()
    return display.newScene("GameScene")
end)

function GameScene:ctor()
    local label = ui.newTTFLabel({text = "少年の日常", size = 32, align = ui.TEXT_ALIGN_CENTER})
        :pos(display.cx, display.top - 50)
        :addTo(self, 100)
    label:setColor(ccc3(255, 0, 0))
    local bg = Background:create()

    self:addChild(bg)
end

function GameScene:newButton(imageName, listener)
    local sprite = display.newSprite(imageName)
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
            if touchInSprite then listener() end
            sprite:setOpacity(255)
        else
            sprite:setOpacity(255)
        end
    end)

    return sprite
end

function GameScene:onEnter()
    if device.platform == "android" then
        -- avoid unmeant back
        self:performWithDelay(function()
            -- keypad layer, for android
            local layer = display.newLayer()
            layer:addKeypadEventListener(function(event)
                if event == "back" then app.exit() end
            end)
            self:addChild(layer)

            layer:setKeypadEnabled(true)
        end, 0.5)
    end
end

function GameScene:onExit()
end

return GameScene
