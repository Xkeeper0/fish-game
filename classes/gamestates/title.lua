local title	= {}


function title:update(dt)
	-- ?
end


function title:draw()
	love.graphics.print("Push button to start game", 10, 10)
end


function title:keypressed(key)
	if key == "return" then
		Gamestate.switch(gamestates.ingame)
	end
end


return title
