Class	= require "libs/hump/class"

Entity = Class {
	init = function(self, world, x, y, w, h)
		self.type = "entity"
		self.position = { x = x, y = y }
		self.bounds = { x = w, y = h }
		self.world = world
	end
}

function Entity:draw()
	r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(255,0,0)
	love.graphics.rectangle("line",
		self.position.x, self.position.y,
		self.bounds.x, self.bounds.y)
	love.graphics.setColor(r,g,b,a)
end

return Entity
