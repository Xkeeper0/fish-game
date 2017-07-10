local TitleScreen	= {}
local boring		= .5

function TitleScreen:update(dt)

end


function TitleScreen:draw()
	love.graphics.print("fish game\n\nsorry\nnot finished\n\npush enter\nuse z/x", 10, 10)
end


function TitleScreen:keypressed(key)
	if key == "return" then
		Gamestate.switch(gamestates.InGame)
	end
end


return TitleScreen
