Class	= require("libs/hump/class")
Bump	= require("libs/bump/bump")

Entity	= require("objects/entity")

Map = Class {
	init = function(self)
		self.world = Bump.newWorld(64)
		self.entities = {}
		self.floors = {}

		local e1 = Entity(self.world,32,32,32,64)

		self.world:add(e1, e1.position.x, e1.position.y, e1.bounds.x, e1.bounds.y)
		table.insert(self.entities, e1)
	end
}

function Map:draw()
	for _, floor in ipairs(self.floors) do
		local r,g,b,a = love.graphics.getColor()
		love.graphics.setColor(64,128,128)
		love.graphics.rectangle("fill",
			floor.x, floor.y, floor.w, floor.h)
		love.graphics.setColor(r,g,b,a)
	end

	for _, entity in ipairs(self.entities) do
		entity:draw()
	end
end

return Map
