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


return Lure
