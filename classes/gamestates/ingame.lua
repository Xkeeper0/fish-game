local InGame	= { entered = false }


function InGame:enter()
	if not entered then
		self.objects			= {}
		self.objects.player		= Player("player", Vector(WATER_WIDTH + 2, WATER_HEIGHT - 16))
		self.objects.lure		= Lure("L", Vector(WATER_WIDTH + 1, WATER_HEIGHT - 16))
		self.objects.fish		= {}
		for i = 0, FISH_COUNT do
			self.objects.fish[i]	= Object("obj #".. i, Vector(love.math.random(16, WATER_WIDTH - 16), love.math.random(WATER_HEIGHT + 8, WATER_DEPTH - 16)))
		end

		self.entered	= true
	end
end


-- Update objects.
-- Passes self (this) to objects so they can ref other objects.
--
function InGame:update(dt)

	self.objects.player:update(dt, self)
	self.objects.lure:update(dt, self)
	for k, v in pairs(self.objects.fish) do
		v:update(dt, self)
	end
end


function InGame:draw()
	love.graphics.print("In game", 10, 10)

	-- Draw a simple background
	love.graphics.setColor(166, 193, 237)	-- Sky
	love.graphics.rectangle("fill", 0, 0, GAME_WIDTH, GAME_HEIGHT)
	love.graphics.setColor(86, 43, 2)	-- Ground
	love.graphics.rectangle("fill", 0, WATER_HEIGHT, GAME_WIDTH, GAME_HEIGHT - WATER_HEIGHT)
	love.graphics.setColor(15, 170, 193)	-- Water
	love.graphics.rectangle("fill", 0, WATER_HEIGHT, WATER_WIDTH, WATER_DEPTH - WATER_HEIGHT)
	love.graphics.setColor(255, 255, 255)	-- Reset

	-- Draw the various objects
	-- Todo: Probably just write something that can do this
	-- without having to call specific ones by name?
	self.objects.player:draw()
	self.objects.lure:draw()
	for k, v in pairs(self.objects.fish) do
		v:draw()
	end
end


return InGame
