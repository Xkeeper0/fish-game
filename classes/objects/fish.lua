
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
	size		= { w = 16, h = 16 },	-- Width/height of fish
	state		= state.idle,			-- Current state
	stateTimer	= 0,					-- State timer
	swimSpeed	= 30,					-- Max velocity for swimming
	swimTime	= .3,					-- How long to swim at full power
	swimDirection	= -1,				-- Direction to go swimming
	idleTime	= { min = 1.5, max = 4 },	-- How long to stay idle after swimming
	senseRange	= 10,					-- How big of a radius we look for lures
	senseOffset	= 8,					-- How far "forward" the circle's origin is
	lungeTimer	= 1,					-- How long to wait before lunging
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
	print(self.state, self.stateTimer)
	-- fishbrain.exe
	if self.state == state.idle then
		-- Don't do anything valuable, just be a boring fish.
		-- Slow down in water though
		self:rest()


		if self.stateTimer < 0 then
			self:startSwimming()
		end

		-- Check if the lure is in range, and if so go after it
		if self:sense(game.objects.lure) then
			self:startTracking()
		end

	elseif self.state == state.swimming then
		-- Swim! That's pretty important I guess.
		-- @TODO Don't go into walls or anything stupid, gosh
		self.velocity.x	= self.swimSpeed * self.swimDirection
		if self.stateTimer < 0 then
			self:startIdling()
		end

		-- Check if the lure is in range, and if so go after it
		if self:sense(game.objects.lure) then
			self:startTracking()
		end

	elseif self.state == state.tracking then
		-- That sure is a shiny lure
		-- Meet its y position and stay away horizontally from it by a bit
		self:trackObject(game.objects.lure, -16 * (self.swimDirection), 0, 6)
		if self.stateTimer < 0 then
			self:startLunging()
		end

	elseif self.state == state.lunging then
		-- Is that thing edible?
		-- I'm gonna eat it
		-- Lunge directly at it!
		local distance	= self:trackObject(game.objects.lure, 0, 0, 18)
		if distance < 1 then
			self:getHooked(game.objects.lure)
		end

	elseif self.state == state.hooked then
		-- shit

		-- Stay on top of it
		self.position.x	= game.objects.lure.position.x - 6
		self.position.y	= game.objects.lure.position.y

		-- Face right/left/idk @TODO fix this
		self.swimDirection	= 1

		-- Stop moving
		self.velocity.x	= 0
		self.velocity.y	= 0

		if self.stateTimer < 0 then
			self.stateTimer				= love.math.random(self.resistInt * .8, self.resistInt * 1.2)
			game.objects.lure.velocity	= (self.position - Vector(WATER_WIDTH, WATER_HEIGHT)):trimmed(self.resistPower)
		end
		-- @TODO tug at it???????? shit
	end

	--print(self.state, self.stateTimer, self.position, self.velocity)
	self:doMovement(dt)

	-- @TODO: Swim boredly
	-- @TODO: Try not to bump into walls
	-- @TODO: Sense hooks

end



-- Is the lure nearby? If so, then boy howdy we found it.
function Fish:sense(lure)
	local hitbox	= Vector(self.position.x + (self.senseOffset * self.swimDirection), self.position.y)
	local distance	= (hitbox - lure.position):len()
	return (distance <= self.senseRange)
end


-- Chillax and breathe or something
function Fish:rest()
	self.velocity	= self.velocity * 0.95
end


-- Start doing nothing
function Fish:startIdling()
	self.stateTimer	= love.math.random(self.idleTime.min, self.idleTime.max)
	self.state		= state.idle
end

-- Start swimming
function Fish:startSwimming()
	-- Turn around and start swimming
	self.stateTimer		= self.swimTime
	self.state			= state.swimming
	self.swimDirection	= self.swimDirection * -1
end

-- Start tracking the lure
function Fish:startTracking()
	self.stateTimer	= self.lungeTimer
	self.state		= state.tracking
end

-- Lunge for it!
function Fish:startLunging()
	self.state		= state.lunging
end

-- Aw crap now we did it
function Fish:getHooked(lure)
	self.state			= state.hooked
	lure.hookedThing	= self
end

-- Track (follow) an object somewhere, staying away by distX/distY
function Fish:trackObject(object, distX, distY, speed)
	local target	= Vector(object.position.x + distX, object.position.y + distY)
	local distance	= (target - self.position)
	self.velocity	= (distance * speed)
	return distance:len()
end

function Fish:draw()
	-- @TODO Use self.image + state check
	local image		= Images.BigFish.normal
	if self.state == state.lunge or self.state == state.tracking then
		image		= Images.BigFish.lunge
	end
	love.graphics.draw(image, self.position.x, self.position.y, 0, self.swimDirection, 1, (self.size.w / 2), (self.size.h / 2))
end

return Fish
