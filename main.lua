--[[
-- Fish game -------------------------------------

Welcome to Fish Game, a game where you catch fish, I guess


--]]


-- Libraries -------------------------------------

-- Import some things from the hump library
-- http://hump.readthedocs.io/
Gamestate		= require "hump.gamestate"
Class			= require "hump.class"
Timer			= require "hump.timer"
Vector			= require "hump.vector"
-- PixelPerfect drawing code
PixelPerfect	= require "utils.pixelperfect"

-- Import some definitions
require "defines"

-- Import all of our classes and some utilities
require "classes"
require "utils"

-- Holder for important stuff
Images			= {}
Sounds			= {}



function love.load()
	Gamestate.registerEvents()
	Gamestate.switch(gamestates.TitleScreen)

	-- Set default graphics filter
	love.graphics.setDefaultFilter("nearest", "nearest", 1)

	-- Make our game 3x scaled
	PixelPerfect:load(256, 224, 3)

	-- Double-wrap the love.draw function.
	-- Gamestate.registerEvents wraps it, but we want to wrap it too
	-- There's no easy way to say "register ALL but this callback"
	-- :(
	local oldDraw = love.draw
	love.draw = function(...)
		drawWrapper(oldDraw, ...)
	end

		Images.Lure		= {
			up		= love.graphics.newImage("assets/images/lure-up.png"),
			down	= love.graphics.newImage("assets/images/lure-down.png"),
			}

		Images.BigFish	= {
			normal	= love.graphics.newImage("assets/images/fish-swim.png"),
			lunge	= love.graphics.newImage("assets/images/fish-lunge.png"),
			}

end


function love.update(dt)
end




-- Wrapper around hump.Gamestate's wrapper around love.draw
-- This scales the game to 3X (or whatever)
function drawWrapper(wrappedDrawer, ...)

	-- Start upscaling canvas code here
	PixelPerfect:startCanvas()
	PixelPerfect:solidBG()

	-- -----------------------------------------------------------------------
	-- Do game drawing stuff here !!!!
	wrappedDrawer()
	-- -----------------------------------------------------------------------

	-- End upscaling canvas and draw it to screen
	PixelPerfect:endCanvas()

	-- Stuff below here is rendered directly on the game screen at 1x
	love.graphics.print(string.format("%4d fps\n%7.4fs\n%7.4fs", love.timer.getFPS(), love.timer.getAverageDelta(), love.timer.getDelta()), 320 * 3 - 70, 5)

end


function love.draw()
	PixelPerfect:startCanvas()
	PixelPerfect:solidBG()
end
