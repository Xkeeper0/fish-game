--[[
-- Fish game -------------------------------------

Welcome to Fish Game, a game where you catch fish, I guess


--]]


-- Libraries -------------------------------------

-- Import some things from the hump library
-- http://hump.readthedocs.io/
Gamestate	= require "hump.gamestate"
Class		= require "hump.class"
Timer		= require "hump.timer"
Vector		= require "hump.vector"


gamestates	= {}
gamestates['title']		= require "classes.gamestates.title"
gamestates['ingame']	= require "classes.gamestates.ingame"

function love.load()
	Gamestate.registerEvents()
	Gamestate.switch(gamestates.title)
end


function love.update(dt)
end


function love.draw()
end
