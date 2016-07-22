Class	= require("libs/hump/class")
Entity	= require("objects/entity")

Creature = Class {
	init = function(self, x, y, w, h)
		__includes = Entity
		self.type = "creature"
		self.position = { x = x, y = y }
		self.bounds = { x = w, y = h }
	end
}

function Creature:update(self, dt)

end

function Creature:draw(self)
		local size = 1
		r, g, b, a = love.graphics.getColor()
		love.graphics.setColor(255,80,80)
		love.graphics.rectangle("line",
			self.position.x - self.bounds.x, self.position.y - self.bounds.y,
			self.bounds.x, self.bounds.y)
		love.graphics.setColor(r,g,b,a)
end

return Creature
