local Lure	= Class{
	__includes	= Object,
	castLure	= 0,		-- Current phase of lure-casting
	inWater		= false,	-- Has it hit water yet?
	hookedThing	= false,	-- Object we've hooked (if anything)
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
	local holdingButton	= love.keyboard.isDown("z", "x")

	print(self.castLure, self.inWater, holdingButton, self.velocity)

	if not self.inWater then

		if self.castLure == 0 and holdingButton then
			-- launch lure off to upper-left
			self.velocity	= Vector(-220, -30)
			self.castLure	= 1

		elseif self.castLure >= 1 and not self.inWater then
			if holdingButton and self.castLure == 1 then
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

	elseif self.inWater then

		self.velocity.y	= math.min(10, self.velocity.y + 0.1)
		if self.position.y >= WATER_DEPTH then
			self.position.y	= WATER_DEPTH
			self.velocity.y	= 0
		end

		-- @TODO Reel in if button pushed. Faster if mashed, slowly if held
	end

	self:doMovement(dt)
end



function Lure:cast()
	-- @TODO Set movement
end


function Lure:reelIn(strength)
	-- @TODO Reel line in with given strength
end



return Lure
