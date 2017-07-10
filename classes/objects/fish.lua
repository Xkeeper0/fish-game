
-- State table of fish brains
local state		= {
	idle		= 0,	-- Not swimming at all
	swimming	= 1,	-- Swimming
	tracking	= 2,	-- Found a lure (stopping)
	lunging		= 3,	-- Lunging at the lure
	hooked		= 4,	-- Attached to the lure
	}

local Fish	= Class{
	__includes	= Object,
	-- @TODO: Make this better somehow? Table of state timers?
	images		= false,				-- Table of images to use
	state		= state.idle,			-- Current state
	stateTimer	= 0,					-- State timer
	swimSpeed	= 30,					-- Max velocity for swimming
	swimTime	= .3,					-- How long to swim at full power
	swimDirection	= -1,				-- Direction to go swimming
	idleTime	= { min = 1.5, max = 4 },	-- How long to stay idle after swimming
	senseRange	= 10,					-- How big of a radius we look for lures
	senseOffset	= 0,					-- How far "forward" the circle's origin is
	lungeTimer	= .5,					-- How long to wait before lunging
	resistPower	= 20,					-- How "strong" it is (swimming away)
	resistInt	= .5,					-- Interval between tugs
	}

-- It's... a fish.
-- Child classes will define the sizes/difficulties I guess

function Fish:init(name, position, velocity, direction)
	self:baseInit(name, position, velocity, direction)

	-- Initialize our fishy
	self.state		= state.idle
	self.stateTimer	= love.math.random(self.idleTime.min, self.idleTime.max)

end

function Fish:update(dt, game)

	-- Slowly time out the current state
	self.stateTimer	= self.stateTimer - dt

	-- fishbrain.exe
	if self.state == state.idle then
		-- Don't do anything valuable, just be a boring fish.
		-- Slow down in water though
		self:rest()


		if self.stateTimer < 0 then
			-- If we're done waiting, turn around and start swimming
			self.stateTimer		= self.swimTime
			self.state			= state.swimming
			self.swimDirection	= self.swimDirection * -1
		end
		-- @TODO sense
		-- Otherwise do nothing

	elseif self.state == state.swimming then
		-- Swim! That's pretty important I guess.
		-- @TODO Don't go into walls or anything stupid, gosh
		self.velocity.x	= self.swimSpeed * self.swimDirection
		if self.stateTimer < 0 then
			self.stateTimer	= love.math.random(self.idleTime.min, self.idleTime.max)
			self.state		= state.idle
		end

		-- @TODO sense

	elseif self.state == state.tracking then
		-- That sure is a shiny lure
		-- Move very slowly towards it (vertically?)

	elseif self.state == state.lunging then
		-- Is that thing edible?
		-- I'm gonna eat it

	elseif self.state == state.hooked then
		-- shit

	end

	print(self.state, self.stateTimer, self.position, self.velocity)
	self:doMovement(dt)

	-- @TODO: Swim boredly
	-- @TODO: Try not to bump into walls
	-- @TODO: Sense hooks

end



function Fish:sense()
	-- @TODO: Check if there is a lure nearby and, if so, go for it
end


function Fish:rest()
	self.velocity	= self.velocity * 0.95
end


function Fish:draw()
	-- @TODO Use self.image.(state)
	local image		= Images.BigFish.normal
	love.graphics.draw(image, self.position.x, self.position.y, 0, self.swimDirection, 1, 8, 8)
end

return Fish
