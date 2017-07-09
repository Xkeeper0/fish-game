local Lure	= Class{
	__includes	= Object,
	cast		= false,	-- Has the line been cast?
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

	if not inWater then
		if not self.cast and holdingButton then
			-- launch lure off to upper-left

		elseif self.cast and not self.inWater then
			-- decelerate slowly if held, faster if not

		end

		-- @TODO Check if lure has hit water

	elseif inWater then
		-- @TODO Slowly sink to bottom
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
