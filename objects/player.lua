Class	= require "libs/hump/class"

local _GRAVITY = 9.8

Player = Class {
	init = function(self, world, x, y, w, h)
		self.type = "player"
		self.position = { x = x, y = y }
		self.bounds = { x = w, y = h }
		self.world = world
		--
		self.prop = { }
		self.prop.velocity = { x = 0, y = 0 }
		self.prop.grounded = false
	end
}

function Player:update(dt)
	if not self.prop.grounded then
		self.prop.velocity.y = self.prop.velocity.y + GRAVITY
	end
	--
	local px_x, px_y = 0, 0

end

function Player:draw()
	r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(128,128,0)
	love.graphics.rectangle("line",
		self.position.x, self.position.y,
		self.bounds.x, self.bounds.y)
	love.graphics.setColor(r,g,b,a)
end

function Player:setPos(x,y)
	self.position.x = x or self.position.x
	self.position.y = y or self.position.y
end
function Player:getPos() return self.position.x, self.position.y end

return Player
