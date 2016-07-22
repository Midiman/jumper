Gamestate = require("libs/hump/gamestate")

function love.load()
    local boot = require("states/platform")
    -- Let's Gamestate
    Gamestate.registerEvents()
    Gamestate.switch(boot)
end

function love.draw()

end

function love.update()

end

function love.keypressed(key, scancode, isrepeat)
    if( key == "escape" ) then
        love.event.quit()
    end
end
