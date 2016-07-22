local state = {}

function state:init() end
--
function state:enter(previous, ...) end
function state:leave() end
function state:resume() end
--
function state:focus() end
--
function state:update(dt) end
function state:draw() end
--
return state
