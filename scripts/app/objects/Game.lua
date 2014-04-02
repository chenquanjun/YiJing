require "app/objects/extern"

--此处继承CCNode,因为需要维持这个表，但是用object的话需要retian/release
Game = class("Game", function()
return CCNode:create()
end)

Game.__index = Game

function Game:create()
local ret = Game.new()
	ret:init()
return ret
end

function Game:init()

end

function Game:onRelease()
end