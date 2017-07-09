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
	for k, v in pairs(self.objects.fish) do
		v:update(dt, self)
	end
end


function InGame:draw()
	love.graphics.print("In game", 10, 10)

	self.objects.player:draw()
	self.objects.lure:draw()
	for k, v in pairs(self.objects.fish) do
		v:draw()
	end
end


return InGame
