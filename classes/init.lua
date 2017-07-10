-- Classes ---------------------------------------
Object		= require "classes.objects.object"
Player		= require "classes.objects.player"
Lure		= require "classes.objects.lure"
Fish		= require "classes.objects.fish"


-- Game States -----------------------------------
gamestates	= {}
gamestates['TitleScreen']	= require "classes.gamestates.title"
gamestates['InGame']		= require "classes.gamestates.ingame"
