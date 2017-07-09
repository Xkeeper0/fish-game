local InGame	= {}


function InGame:enter()
	InGame.player	= Player("player")
	InGame.objects	= {}
	for i = 0, 4 do
		InGame.objects[i]	= Object("obj #".. i, Vector(i * 20, i * 10 + 20))
	end
end


function InGame:update(dt)
	-- ?
end


function InGame:draw()
	love.graphics.print("In game", 10, 10)

	InGame.player:draw()
	for k, v in pairs(InGame.objects) do
		v:draw()
	end
end


return InGame
