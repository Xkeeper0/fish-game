-- Classes ---------------------------------------
Object		= require "classes.objects.object"
Player		= require "classes.objects.player"


-- Game States -----------------------------------
gamestates	= {}
gamestates['TitleScreen']	= require "classes.gamestates.title"
gamestates['InGame']		= require "classes.gamestates.ingame"
