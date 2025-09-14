extends Area2D

@onready var sprite = $Sprite
@onready var current_scene = get_parent()

var tile_size = 32
var INPUTS = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN
			}

var ANIMATIONS = {
	"right" : "RightWalk",
	"left" : "RightWalk",
	"up" : "BackWalk",
	"down" : "FrontWalk"
}

# helper functions

func move(dir):
	sprite.stop()
	sprite.play(ANIMATIONS[dir])
	if current_scene.mother_can_i_interact() == dir:
		current_scene.i_am_interacting()
	if current_scene.mother_may_i_move(dir):
		position += INPUTS[dir] * tile_size
	
# end helper functions

			
func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2

func _unhandled_input(event):
	for dir in INPUTS.keys():
		if event.is_action_pressed(dir):
			sprite.flip_h = (dir == "left")
			move(dir)
			
