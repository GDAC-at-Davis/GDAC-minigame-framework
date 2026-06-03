extends Node2D

@onready var visual_tilemap = $VisualTileMap
@onready var collision_tilemap = $CollisionTileMap

var CELL_SIZE = 32
var SPAWN_CELL_ID = 4
var WALKABLE_CELLS = [0, 1, 2, 3, 4, 6]
var INTERACTION_DICT = {
	0 : "down",
	1 : "left",
	2 : "right",
	3 : "up"
}

var INPUTS = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN
			}

var INTERACTABLE_TILES_DICT = {
	Vector2i(1, 4) : "bed",
	Vector2i(0, 5) : "bed",
	Vector2i(-4, -2) : "mirror",
	Vector2i(1, -2) : "door",
	Vector2i(-4, 3) : "bloon",
	Vector2i(-3, 4) : "bloon",
	Vector2i(-4, 5) : "bloon"
	}
	
var INTERACTABLE_TEXT_DICT = {
	"bed" = ["Oh, I sleep here."],
	"mirror" = ["I'm an abomination"],
	"door" = ["get me out of here"],
	"bloon" = ["Oh, a hero!",
	"Thank goodness you're here. I need your help, urgently.",
	"I have many enemies, but none quite as dastardly as those godforsaken STRINGIES.",
	"O valiant hero, I have but one mission for you.",
	"KILL AS MANY AS YOU CAN!"]
}

func interact(interaction : String):
	match interaction:
		"bed":
			GameManager.world_manager.active_ui.play_text(INTERACTABLE_TEXT_DICT["bed"])
		"mirror":
			GameManager.world_manager.active_ui.play_text(INTERACTABLE_TEXT_DICT["mirror"])
		"door":
			GameManager.world_manager.active_ui.play_text(INTERACTABLE_TEXT_DICT["door"], preload("res://resources/minigame_groups/home_minigame_group.tres"))
		"bloon":
			GameManager.world_manager.active_ui.play_text(INTERACTABLE_TEXT_DICT["bloon"], preload("res://resources/minigame_groups/bloon_minigames.tres"))
		
