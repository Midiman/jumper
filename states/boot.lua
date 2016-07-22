local state = {}
local _color = {44, 62, 80}

function state:init()

end
--
function state:update(dt) end
function state:draw()
    love.graphics.setColor(unpack(_color))
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
end
--
return state
