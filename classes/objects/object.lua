local Object	= Class{
	position	= nil,
	velocity	= nil,
	direction	= 0,
	name		= "Name",
	type		= "Object",
	}


function Object:init(name, position, velocity, direction)
	print(name, position, velocity, direction)
	self.name		= defaultArg(name, self.name)
	self.position	= defaultArg(position, Vector(0, 0))
	self.velocity	= defaultArg(velocity, Vector(0, 0))
	self.direction	= defaultArg(direction, self.direction)
end


function Object:update(dt, game)
	self.position	= self.position + self.velocity * dt
end

function Object:draw()
	love.graphics.print(self.name, self.position.x, self.position.y)
end

function Object:setPosition(v)
	self.position	= v
end

function Object:setVelocity(v)
	self.velocity	= v
end

function Object:setDirection(d)
	self.direction	= d
end


return Object
