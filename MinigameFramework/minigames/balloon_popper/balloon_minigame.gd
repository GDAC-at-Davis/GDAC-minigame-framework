extends Minigame

var balloon_packed_scene: PackedScene = preload("res://minigames/balloon_popper/Balloon.tscn")
var balloons: Array[Area2D]
var pop_count: int = 0
var base_balloon_amount: int = 3
var balloon_amount: int = base_balloon_amount

@onready var particles: GPUParticles2D = $BalloonParticles

func start():
	# Reset variables
	balloons.clear()
	pop_count = 0
	balloon_amount = base_balloon_amount
	particles.emitting = false
	
	# Adjust for difficulty
	countdown_time /= difficulty
	balloon_amount *= difficulty
	
	# Spawn the balloons
	for i in range(balloon_amount):
		var balloon: Area2D = balloon_packed_scene.instantiate()
		balloons.append(balloon)
		add_child(balloon)
		balloon.global_position = Vector2(randf_range(0, get_viewport().size.x), randf_range(0, get_viewport().size.y))

func win():
	super()
	particles.emitting = true

func balloon_popped():
	pop_count += 1
	if pop_count == balloon_amount:
		win()
