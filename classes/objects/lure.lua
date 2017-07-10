local Lure	= Class{
	__includes	= Object,
	castLure	= 0,		-- Current phase of lure-casting
	inWater		= false,	-- Has it hit water yet?
	hookedThing	= false,	-- Object we've hooked (if anything)
	lastButton	= false,	-- Was the button pushed last update?
	holdButton	= false,	-- Is the button pressed this update?
	catchPoint	= Vector(WATER_WIDTH, WATER_HEIGHT),	-- Where the "catch point" is
	}

-- The lure is going to do most of the work.
-- If a fish is near it, it should lunge
-- if the hook is currently not occupied.
-- Also should probably handle movement

-- States can either be a mix of individual flags
-- or perhaps something else (just a text defn.?)
-- e.g. cast + !inWater = flying through air
--      hooked + !inWater = "catching"
-- idk maybe other things.



function Lure:update(dt, game)

	-- @TODO Definable buttons or something
	self.lastButton		= self.holdingButton
	self.holdingButton	= love.keyboard.isDown("z", "x")


	--print(self.castLure, self.inWater, self.holdingButton, self.velocity)

	if not self.inWater then
		self:handleCasting()

	elseif self.inWater then
		self:handleInWater()

		if self.holdingButton then
			-- Reel in the lure. Tapping should give
			-- better results than holding.
			-- @TODO: Handle different "directions"
			-- e.g. tap right to gently tug rightward
			-- or up to nudge more upwards

			local strength	= 10
			if not self.lastButton then
				strength	= 75
			end
			self:reelIn(strength)
		end
	end

	self:doMovement(dt)
end



-- Handle the casting of the lure.
-- If the button is pressed, shoot it out towards water
-- If not, don't do anything
function Lure:handleCasting()
	if self.castLure == 0 and self.holdingButton then
		-- launch lure off to upper-left
		self.velocity	= Vector(-220, -30)
		self.castLure	= 1

	elseif self.castLure >= 1 and not self.inWater then
		if self.holdingButton and self.castLure == 1 then
			-- "Holding the line open"; lure will fly farther
			self.velocity.x	= self.velocity.x * .98
			self.velocity.y	= math.min(40, self.velocity.y + .5)
		else
			-- No longer holding it open; lure should stop quickly and sink
			-- Can't go back to "free flying" after reaching here
			self.castLure	= 2
			self.velocity.x	= self.velocity.x * .93
			self.velocity.y	= math.min(40, self.velocity.y + 1)
		end

		if self.position.y >= WATER_HEIGHT then
			-- Hit the water!
			print("sploosh")
			self.inWater	= true
			self.velocity.x	= 0
			self.velocity.y	= 2
		end
	end

end


-- Slow down movement and sink towards the bottom
-- Stop if we hit the bottom though;
-- @TODO Stop if we hit the right wall, too
function Lure:handleInWater()
	self.velocity.y	= math.min(10, self.velocity.y + 0.1)
	self.velocity.x	= self.velocity.x * 0.97
	if self.position.y >= WATER_DEPTH then
		self.position.y	= WATER_DEPTH
		self.velocity.x	= 0
		self.velocity.y	= 0
	end
end


function Lure:reelIn(strength)
	-- @TODO Reel line in with given strength
	-- Get the vector from current position to the corner of the water
	-- This is NOT the player position b/c the player is slightly farther away
	-- Then, cap the vector length to the "strength" argument
	local tempVector	= self.catchPoint - self.position
	self.velocity		= (tempVector):trimInplace(strength)

	print(self.catchPoint, self.position, tempVector, self.velocity)
end



return Lure
