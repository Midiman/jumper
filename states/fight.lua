Class	= require("libs/hump/class")
Vector	= require("libs/hump/vector")
Bump	= require("libs/bump/bump")


local state = {}
local color = {
	-- stage
	background	= { 32, 32, 32 },
	foreground	= { 80, 80, 80 },
	-- info
	origin		= {191, 85, 236, 128},
	origin2		= {142, 68, 173},
	bounds		= {25, 181, 254, 32},
	bounds2		= {34, 167, 240}
}

Fighter = Class {
	init = function(self, x, y, world)
		self.pos = Vector(x,y)
		self.bounds = Vector(160,320)
		self.world = world
		self.world:add(self, self.pos.x, self.pos.y, self.bounds.x, self.bounds.y)
	end,
	--
	setPos = function(self, x, y)
		self.pos = Vector(x,y)
	end,
	--
	update = function(self, dt)

	end,
	draw = function(self)
		love.graphics.setColor(unpack(color.bounds))
		love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.bounds.x, self.bounds.y)
		love.graphics.setColor(unpack(color.bounds2))
		love.graphics.rectangle("line", self.pos.x, self.pos.y, self.bounds.x, self.bounds.y)
	end
}

function state:init()
	self.entities = {}
	self.world = Bump.newWorld(64)
	--

	-- lazy
	local x1, x2 = 240, 960
	local fighter1 = Fighter(x1, 320, self.world)
	local fighter2 = Fighter(x2, 320, self.world)
	table.insert(self.entities, fighter1)
	table.insert(self.entities, fighter2)
end
--
function state:update(dt) end
function state:draw()
	--
	love.graphics.setColor(unpack(color.background))
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
	--
	for _, entity in ipairs(self.entities) do
		entity:draw()
	end
end
--
return state
