require "app/objects/extern"
require "app/objects/Player"

--此处继承CCNode,因为需要维持这个表，但是用object的话需要retian/release
Background = class("Background", function()
return CCNode:create()
end)

Background.__index = Background

local _bgSpriteVec = {}

local _msgLabel = nil

function Background:create()
	local ret = Background.new()
		ret:init()
	return ret
end

function Background:init()
    self:initBackground()
    self:initBtn()
end

function Background:showMsg(string)
    local label = _msgLabel
        local sequence = transition.sequence({
                CCEaseBackOut:create(CCMoveBy:create(0.3, ccp(0, 100))),
                CCDelayTime:create(1.0),
                CCFadeOut:create(0.5),
                CCHide:create(),
            })

        sequence:setTag(88)
        label:stopActionByTag(88)
        label:setVisible(true)
        label:setPosition(display.left + 200, display.bottom)
        label:setString(string)
        label:setOpacity(255)
        label:runAction(sequence)
end

function Background:initBackground()

    local label = ui.newTTFLabel({text = "hmmmmm", size = 20, align = ui.TEXT_ALIGN_CENTER})
    :addTo(self, 100)
    label:setColor(ccc3(68, 206, 246))

    _msgLabel = label
    label:setVisible(false)

    local index = 1
     do --早上课室
        local bg = display.newSprite("back_class_normal.png")
        bg:setVisible(false)
        bg:setPosition(ccp(display.cx, display.cy))
        bg:setScaleX(640/512)
        bg:setScaleY(640/512)
        self:addChild(bg)
        _bgSpriteVec[index] = bg
        index = index + 1
    end

    do --下午课室
        local bg = display.newSprite("back_class_sunset.png")
        bg:setVisible(false)
        bg:setPosition(ccp(display.cx, display.cy))
        bg:setScaleX(640/512)
        bg:setScaleY(640/512)
        self:addChild(bg)
        _bgSpriteVec[index] = bg
        index = index + 1
    end

    do --早上房间
        local bg = display.newSprite("back_room_normal.png")
        bg:setVisible(false)
        bg:setPosition(ccp(display.cx, display.cy))
        bg:setScaleX(640/512)
        bg:setScaleY(640/512)
        self:addChild(bg)
        _bgSpriteVec[index] = bg
        index = index + 1
    end

    do --下午房间
        local bg = display.newSprite("back_room_sunset.png")
        bg:setVisible(false)
        bg:setPosition(ccp(display.cx, display.cy))
        bg:setScaleX(640/512)
        bg:setScaleY(640/512)
        self:addChild(bg)
        _bgSpriteVec[index] = bg
        index = index + 1
    end

    do --晚上房间
        local bg = display.newSprite("back_room_night.png")
        bg:setVisible(false)
        bg:setPosition(ccp(display.cx, display.cy))
        bg:setScaleX(640/512)
        bg:setScaleY(640/512)
        self:addChild(bg)
        _bgSpriteVec[index] = bg
        index = index + 1
    end

    do --自定义房间
        local bg =display.newLayer()
        bg:setVisible(false)
        -- bg:setPosition(ccp(display.cx, display.cy))
        self:addChild(bg)
        _bgSpriteVec[index] = bg
        index = index + 1



        do --window
            local openVisible = true
            local closeVisible = false

            local curtainOpen = display.newSprite("curtain_open.png")
            bg:addChild(curtainOpen, 2)
            curtainOpen:setPosition(ccp(display.right - 225, display.top - 150)) 
            curtainOpen:setScale(0.8)
            curtainOpen:setVisible(openVisible)

            local curtainClose = display.newSprite("curtain_close.png")
            bg:addChild(curtainClose, 2)
            curtainClose:setPosition(ccp(display.right - 225, display.top - 250)) 
            curtainClose:setScale(0.8)
            curtainClose:setVisible(closeVisible)

            local sprite = display.newSprite("window.png")
            bg:addChild(sprite)
            sprite:setPosition(ccp(display.right - 200, display.top - 250)) 
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

        do --bookshelf
            local bookshelf = display.newSprite("bookshelf.png")
            bg:addChild(bookshelf)
            bookshelf:setPosition(ccp(display.left + 60, display.cy)) 
            bookshelf:setScale(0.5)
        end


     
    end

    local player = Player:create()

    self:addChild(player)


    do --desk
        local desk = display.newSprite("desk.png")    
        self:addChild(desk)
        desk:setScale(0.5)
        local rect = desk:getBoundingBox()
        desk:setPosition(ccp(display.cx, display.bottom + rect.size.height * 0.5)) 
            
    end

    do --plate
        local foodStrTable = {}
        foodStrTable[1] = "好好吃哦"
        foodStrTable[2] = "要两颗一起吃"
        foodStrTable[3] = "老板加鸡腿"
        foodStrTable[4] = "根本停不下来"
        foodStrTable[5] = "白天吃热翔，晚上学蓝翔！"
        foodStrTable[6] = "热翔，我的最爱"
        foodStrTable[7] = "好饱喔"
        foodStrTable[8] = "都是我的！"
        foodStrTable[9] = "O(∩_∩)O哈哈~"

        local plate = display.newSprite("plate.png")    
        self:addChild(plate)
        plate:setScale(0.5)
        local rect = plate:getBoundingBox()
        plate:setPosition(ccp(display.cx + 40, display.bottom + rect.size.height * 0.5 + 15)) 

        local totalNum = 0

        local function createFood()

            if totalNum >= 20 then
                return
            end
            totalNum = totalNum + 1

            local num = math.random(1, 3)
            local fileName = string.format("xiang_%i.png", num)
            local food = display.newSprite(fileName)
            plate:addChild(food) 

            food:setScale(0.5)
            local widthOffset = math.random(50, 150)
            local heightOffset = math.random(100, 180)
            food:setPosition(rect.size.width * widthOffset * 0.01, rect.size.height * heightOffset * 0.01)

            food:setTouchEnabled(true) -- enable sprite touch
            food:addTouchEventListener(function(event, x, y)
     
                if event == "began" then
                    food:setScale(0.45)
                    return true -- catch touch event, stop event dispatching
                end

                local touchInSprite = food:getCascadeBoundingBox():containsPoint(CCPoint(x, y))
                if event == "moved" then

                elseif event == "ended" then
                    local strNum = math.random(1, table.getn(foodStrTable))
                    local str = foodStrTable[strNum]
                    self:showMsg(str)
                    food:setVisible(false)
                    food:removeSelf(true)
                    totalNum = totalNum - 1
                end
            end)  
        end

        for i = 1,3 do
            createFood()
        end

        do --food
            local sprite = display.newSprite("refresh.png")
            plate:addChild(sprite)

            sprite:setPosition(rect.size.width * 2.2, rect.size.height * 1.5)
            sprite:setTouchEnabled(true) -- enable sprite touch
            sprite:addTouchEventListener(function(event, x, y)
     
                if event == "began" then
                    sprite:setScale(0.9)
                    return true -- catch touch event, stop event dispatching
                end

                local touchInSprite = sprite:getCascadeBoundingBox():containsPoint(CCPoint(x, y))
                if event == "moved" then

                elseif event == "ended" then
                    createFood()

                    sprite:setScale(1.0)
                else
                    sprite:setScale(1.0) 
                end
            end)   
        end

    end


   
end



function Background:initBtn()
        local bgTable = {}
        bgTable[1] = "早上课室"
        bgTable[2] = "下午课室"  
        bgTable[3] = "早上房间"
        bgTable[4] = "下午房间"
        bgTable[5] = "晚上房间"
        bgTable[6] = "迷の房间^_^"

        
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
                local str = bgTable[index]

                if str then
                    self:showMsg(str)
                end
                bgNow:setVisible(true) 

                sprite:setScale(1.0)
            else
                sprite:setScale(1.0) 
            end
        end)   
end


function Background:onRelease()
end