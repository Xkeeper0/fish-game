local Object	= Class{
	position	= { x = 0, y = 0 },
	velocity	= Vector(0, 0),
	direction	= 0,
	name		= "Name",
	type		= "Object",
	}


function Object:init(name, position, velocity, direction)
	self.name		= defaultArg(name, self.name)
	self.position	= defaultArg(position, self.position)
	self.velocity	= defaultArg(velocity, self.velocity)
	self.direction	= defaultArg(direction, self.direction)

end


function Object:update(dt)
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
