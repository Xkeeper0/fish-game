local TitleScreen	= {}


function TitleScreen:update(dt)
	-- ?
end


function TitleScreen:draw()
	love.graphics.print("Push button to start game", 10, 10)
end


function TitleScreen:keypressed(key)
	if key == "return" then
		Gamestate.switch(gamestates.InGame)
	end
end


return TitleScreen
