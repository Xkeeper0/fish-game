local InGame	= { entered = false }


function InGame:enter()
	if not entered then
		self.objects			= {}
		self.objects.player		= Player("player", Vector(100, 100))
		self.objects.fish		= {}
		for i = 0, 4 do
			self.objects.fish[i]	= Object("obj #".. i, Vector(i * 20, i * 10 + 20))
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
	for k, v in pairs(self.objects.fish) do
		v:draw()
	end
end


return InGame
