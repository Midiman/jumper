Class	= require("libs/hump/class")
Vector	= require("libs/hump/vector")

STI		= require("libs/sti")
Bump	= require("libs/bump/bump")
Tactile	= require("libs/tactile")
cpml	= require("libs/cpml")

GRAVITY	= 980

input = {
	x		= Tactile.newControl()
				:addAxis(Tactile.gamepadAxis( 1,'leftx'))
				:addButtonPair(Tactile.keys( 'a', 'left'), Tactile.keys('d','right')),
	y		= Tactile.newControl()
				:addAxis(Tactile.gamepadAxis( 1,'lefty'))
				:addButtonPair(Tactile.keys( 'w', 'up'), Tactile.keys('s','down')),
	jump	= Tactile.newControl()
				:addButton(Tactile.gamepadButtons(1,'a'))
				:addButton(Tactile.keys('z','space'))
}

Block = Class {
	init = function(self, world, x, y, w, h)
		self.type = "solid"
		self.pos = { x = x, y = y }
		self.bound = { x = w, y = h }
		self.world = world
		--
		self.world:add(self, x, y, w, h)
	end,
	getCenter = function(self)
		return self.pos.x + self.bound.x / 2, self.pos.y + self.bound.x / 2
	end,
	update = function(self, dt)
		--
	end,
	draw = function(self)
		love.graphics.setColor(128,32,32)
		love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.bound.x, self.bound.y)
	end
}

Player = Class {
	init = function(self, world, x, y, w, h)
		self.type = "player"
		self.pos = { x = x, y = y }
		self.bound = { x = w, y = h }
		self.world = world
		--
		self.prop = {
			accel	= 1300,
			decel	= 1200,
			brake	= 2500,
			jump	= -400,
			float	= -560,
			max_x	= 560
		}
		self.vel = { x = 0, y = 0 }
		self.grounded = false
		self.nearWall = false
		--
		self.world:add(self, x, y, w, h)
		self.color = { 255, 255, 255 }
	end,
	getCenter = function(self)
		return self.pos.x + self.bound.x / 2, self.pos.y + self.bound.x / 2
	end,
	getSpeed = function(self)
		return self.vel.x, self.vel.y
	end,
	--
	filter = function(other)
		local type = other.type
		if type == "solid" then
			return "slide"
		end
		return "slide"
	end,
	update = function(self, dt)
		--[[ INPUT DETECTION ]]
		-- input Horiz
		if input.x:isDown(-1) then
			self.vel.x = self.vel.x
		 		- dt * ( self.vel.x > 0 and self.prop.brake or self.prop.accel)
		elseif input.x:isDown(1) then
			self.vel.x = self.vel.x
				+ dt * ( self.vel.x < 0 and self.prop.brake or self.prop.accel)
		else
			local decel = ( ( self.vel.x < 0 ) and self.prop.decel or -self.prop.decel ) * dt
			if math.abs(decel) > math.abs(self.vel.x) then
				self.vel.x = 0
			else
				self.vel.x = self.vel.x + (decel)
			end
		end
		-- input Jump
		if input.jump:isDown() and self.grounded then
			self.grounded = false
			self.vel.y = self.prop.jump
		end
		-- input float
		if input.jump:isDown() and not self.grounded and self.vel.y < 0 then
			self.vel.y = self.vel.y + (self.prop.float * dt)
		end
		-- check
		if not self.grounded then
			self.vel.y = self.vel.y + (GRAVITY * dt)
		end

		-- clamp
		self.vel.x = cpml.utils.clamp( self.vel.x, -self.prop.max_x, self.prop.max_x )

		-- [[ COLLISION ]]
		-- move
		self.grounded = false
		self.nearWall = false
		local future_x = self.pos.x + (self.vel.x * dt)
		local future_y = self.pos.y + (self.vel.y * dt)

		-- check collisions
		local next_x, next_y, cols, len = self.world:move(self, future_x, future_y, self.filter)
		for i = 1, len do
			local col = cols[i]
			local next_vx, next_vy = self.vel.x, self.vel.y
			-- change velocity by collision normal
			if (col.normal.x < 0 and next_vx > 0) or (col.normal.x > 0 and next_vx < 0) then
				self.vel.x = 0
				next_vx = 0
				self.nearWall = true
			end
			if (col.normal.y < 0 and next_vy > 0) or (col.normal.y > 0 and next_vy < 0) then
				next_vy = 0
			end
			-- grounded collision
			if (col.normal.y < 0) then
				self.vel.y = 0
				self.grounded = true
			end

			self.vx = next_vx
			self.vy = next_vy
		end

		-- [[ FINALIZE ]]
		self.pos.x = next_x
		self.pos.y = next_y
		self.color = self.grounded and { 255, 255, 255 } or { 128, 128, 128 }
		self.color = self.nearWall and { 128, 255, 128 } or self.color
	end,
	--
	draw = function(self)
		love.graphics.setColor( unpack( self.color ) )
		love.graphics.rectangle("line", self.pos.x, self.pos.y, self.bound.x, self.bound.y)
	end
}

Map = Class {
	init = function(self, map_path)
		self:restart()
	end,
	restart = function(self)
		self.world	= Bump.newWorld(32)
		self.map = STI("data/maps/00.lua", {"bump"}, self.world)
		--
		self.player	= Player(self.world, 320,320,32,64)
		-- base tiles
		self.entities = {}
		table.insert( self.entities, Block(self.world, 0, 0, 1280, 32) )

		table.insert( self.entities, Block(self.world, 0, 32, 32, 720-64) )
		table.insert( self.entities, Block(self.world, 1280-32, 32, 32, 720-64) )

		local num_tiles = 1280/32
		for i = 0, num_tiles - 1 do
			table.insert( self.entities, Block(self.world, i * 32, 720-32, 32, 32) )
		end
	end,
	update = function(self, dt)
		local visible, len = self.world:queryRect(0,0,1280,720)
		--
		self.map:update(dt)
		for i = 1, len do
			visible[i]:update(dt)
		end
	end,
	draw = function(self)
		local visible, len = self.world:queryRect(0,0,1280,720)
		--
		self.map:draw()
		for i = 1, len do
			visible[i]:draw()
		end
		--
		local _x, _y = self.player:getCenter()
		local _spd, _grv = self.player:getSpeed()
		love.graphics.setColor(255,255,255)
		love.graphics.printf( ("(%03i,%03i)"):format(_x,_y), _x - 192/2, _y - 64, 192, "center")
		love.graphics.printf( ("(%+04i,%+04i)"):format(_spd,_grv), _x - 192/2, _y - 48, 192, "center")
	end
}

local state = {}

function state:init()
	self.map = Map()
end
--
function state:update(dt)
	input["x"]:update()
	input["y"]:update()
	input["jump"]:update()
	self.map:update(dt)
end
function state:draw()
	love.graphics.print(#input, 32, 32)
	self.map:draw()
end
--
return state
