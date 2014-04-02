require "app/objects/Player"
require "app/objects/Background"

local GameScene = class("GameScene", function()
    return display.newScene("GameScene")
end)

function GameScene:ctor()
    local label = ui.newTTFLabel({text = "1", size = 32, align = ui.TEXT_ALIGN_CENTER})
        :pos(display.cx, display.top - 50)
        :addTo(self, 10)

    local bg = Background:create()

    self:addChild(bg)

    local player = Player:create()

    self:addChild(player, 10)


    -- do --player
    -- local player = self:newButton("player.png", function()
    --         print("onPlayer")
    --         label:setString("少年")
    --     end)    
    -- self:addChild(player)
    -- player:setPosition(ccp(display.cx - 50, display.cy)) 
    -- player:setScale(0.8)
    -- end

    -- do --desk
    -- local desk = self:newButton("desk.png", function()
    --         print("ondesk")
    --         label:setString("桌子")
    --     end)    
    -- self:addChild(desk)
    -- desk:setPosition(ccp(display.cx, display.bottom + 60)) 
    -- desk:setScale(0.8)
    -- end

    -- do --window
    -- local window = self:newButton("window.png", function()
    --         print("onwindow")
    --         label:setString("窗子")
    --     end)    
    -- self:addChild(window)
    -- window:setPosition(ccp(display.right - 200, display.top - 250)) 
    -- window:setScale(0.8)
    -- end

    -- do --windowcolor
    -- local windowcolor = self:newButton("windowcolor.png", function()
    --         print("onwindowcolor")
    --         -- label:setString("窗子")
    --     end)    
    -- self:addChild(windowcolor)
    -- windowcolor:setPosition(ccp(display.right - 200, display.top - 250)) 
    -- windowcolor:setScale(0.8)
    -- end

    -- do --curtainOpen
    -- local curtainOpen = self:newButton("curtain_open.png", function()
    --         print("oncurtainOpen")
    --         label:setString("窗帘打开")
    --     end)    
    -- self:addChild(curtainOpen)
    -- curtainOpen:setPosition(ccp(display.right - 225, display.top - 150)) 
    -- curtainOpen:setScale(0.8)
    -- end

    -- do --curtainClose
    -- local curtainClose = self:newButton("curtain_close.png", function()
    --         print("oncurtainClose")
    --         label:setString("窗帘打开")
    --     end)    
    -- self:addChild(curtainClose)
    -- curtainClose:setPosition(ccp(display.right - 225, display.top - 250)) 
    -- curtainClose:setScale(0.8)
    -- end

    -- do --bookshelf
    -- local bookshelf = self:newButton("bookshelf.png", function()
    --         print("onbookshelf")
    --         label:setString("书柜")
    --     end)    
    -- self:addChild(bookshelf)
    -- bookshelf:setPosition(ccp(display.left + 400, display.bottom + 300)) 
    -- bookshelf:setScale(0.8)
    -- end

    -- do --book
    -- local book = self:newButton("book.png", function()
    --         print("onbook")
    --         label:setString("书")
    --     end)    
    -- self:addChild(book)
    -- book:setPosition(ccp(display.left + 325, display.bottom + 250)) 
    -- book:setScale(0.8)
    -- end

    -- do --bookcolor
    -- local bookcolor = self:newButton("bookcolor.png", function()
    --         print("onbookcolor")
    --         label:setString("书")
    --     end)    
    -- self:addChild(bookcolor)
    -- bookcolor:setPosition(ccp(display.left + 80, display.bottom + 280)) 
    -- bookcolor:setScale(0.8)
    -- end

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
