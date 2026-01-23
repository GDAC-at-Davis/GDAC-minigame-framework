extends Node2D



var player_scene = preload("res://scenes/player.tscn")
var player = null
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

# helper functions
func spawn_player():
	# find spawn tile
	var spawn_tile = collision_tilemap.get_used_cells_by_id(SPAWN_CELL_ID)[0]
	
	# spawn player
	player = player_scene.instantiate()
	
	player.position = collision_tilemap.map_to_local(spawn_tile) - Vector2(0.5, 0.5)
	
	add_child(player)

func mother_may_i_move(dir :String) -> bool:
	var target_cell_pos = collision_tilemap.local_to_map(player.position + (CELL_SIZE * INPUTS[dir]))
	var target_cell = collision_tilemap.get_cell_source_id(target_cell_pos)
	if target_cell in WALKABLE_CELLS:
		return true
	else:
		return false
		
func mother_can_i_interact() -> String:
	var current_cell_pos = collision_tilemap.local_to_map(player.position)
	var current_cell = collision_tilemap.get_cell_source_id(current_cell_pos)
	if current_cell in INTERACTION_DICT:
		return INTERACTION_DICT[current_cell]
	else:
		return ''
# end helper functions

func i_am_interacting():
	var player_position =  Vector2i(collision_tilemap.local_to_map(player.position))
	if player_position in INTERACTABLE_TILES_DICT:
		interact(INTERACTABLE_TILES_DICT[player_position])
	
func text_lock_player():
	player.text_locked = true
	
func text_unlock_player():
	player.text_locked = false

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
		

func _ready() -> void:
	spawn_player()
