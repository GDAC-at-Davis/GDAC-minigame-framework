extends Minigame

var balloon_packed_scene: PackedScene = preload("res://minigames/shadowboxing/arrow.tscn")
var arrows: Array[Area2D]
var pop_count: int = 0
var base_balloon_amount: int = 3
var balloon_amount: int = base_balloon_amount

@onready var particles: GPUParticles2D = $BalloonParticles

func start():
	# Reset variables
	arrows.clear()
	pop_count = 0
	balloon_amount = base_balloon_amount
	
	# Adjust for difficulty
	countdown_time /= difficulty
	#balloon_amount *= roundi(difficulty)
	
	# Spawn the arrows
	# for i in range(balloon_amount):
	var arrow: Area2D = balloon_packed_scene.instantiate()
	arrows.append(arrow)
	add_child(arrow)
	arrow.global_position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2 - 200)
	arrows[0].rotation_degrees = 270

func _process(_delta):
	#var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed(&"right"):
		arrows[0].global_position = Vector2(get_viewport().size.x/2 + 400, get_viewport().size.y/2)
		arrows[0].rotation_degrees = 0
	if Input.is_action_pressed(&"left"):
		arrows[0].global_position = Vector2(get_viewport().size.x/2 - 400, get_viewport().size.y/2)
		arrows[0].rotation_degrees = 180
	if Input.is_action_pressed(&"down"):
		arrows[0].global_position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2 + 200)
		arrows[0].rotation_degrees = 90
	if Input.is_action_pressed(&"up"):
		arrows[0].global_position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2 - 200)
		arrows[0].rotation_degrees = 270

func win():
	super()

func balloon_popped():
	pop_count += 1
	if pop_count == balloon_amount:
		win()
