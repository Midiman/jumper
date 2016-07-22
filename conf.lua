function love.conf(t)
    t.identity = nil
    t.version = "0.10.1"
    t.accelerometerjoystick = false
    t.externalstorage = true
    t.gammacorrect = true
    --
    t.window.width = 1280
    t.window.height = 720
    t.window.vsync = true
    t.window.msaa = 1
    --
    t.modules.physics = false

    io.stdout:setvbuf("no")
end
