extends Minigame

var arrow_packed_scene: PackedScene = preload("res://minigames/shadowboxing/arrow.tscn")
var arrows: Array[Area2D]
var direction: int = 0
var move_weight: float = 0.0
var timer: int = 0
var lost: bool = false

@export var movement_curve: Curve

# 0: up, 1: right, 2: down, 3: left (think of compass, never eat soggy waffles!)

@onready var particles: GPUParticles2D = $BalloonParticles

func start():
	# Reset variables
	arrows.clear()
	timer = 0
	
	# Adjust for difficulty
	countdown_time /= difficulty
	#balloon_amount *= roundi(difficulty)
	
	# Spawn the arrows
	# for i in range(balloon_amount):
	#for i in 4: 
	#	var arrow: Area2D = arrow_packed_scene.instantiate()
	#	arrows.append(arrow)
	#	add_child(arrow)
	#	#arrows.move_time = 0
	#	if i == 0:
	#		arrows[i].global_position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2 - 200)
	#		arrows[i].rotation_degrees = 270
	#	elif i == 1:
	#		arrows[i].global_position = Vector2(get_viewport().size.x/2 + 400, get_viewport().size.y/2)
	#		arrows[i].rotation_degrees = 0
	#	elif i == 2:
	#		arrows[i].global_position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2 + 200)
	#		arrows[i].rotation_degrees = 90
	#	elif i == 3:
	#		arrows[i].global_position = Vector2(get_viewport().size.x/2 - 400, get_viewport().size.y/2)
	#		arrows[i].rotation_degrees = 180
	
	#arrow.global_position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2 - 200)
	#arrows[0].rotation_degrees = 270

func run():
	timer += 1
	
	if (timer == 20):
		var arrow: Area2D = arrow_packed_scene.instantiate()
		arrows.append(arrow)
		add_child(arrow)
		direction = randi_range(0, 3)
		if direction == 0:
			arrows[0].global_position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2 - 200)
			arrows[0].rotation_degrees = 270
		elif direction == 1:
			arrows[0].global_position = Vector2(get_viewport().size.x/2 + 400, get_viewport().size.y/2)
			arrows[0].rotation_degrees = 0
		elif direction == 2:
			arrows[0].global_position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2 + 200)
			arrows[0].rotation_degrees = 90
		elif direction == 3:
			arrows[0].global_position = Vector2(get_viewport().size.x/2 - 400, get_viewport().size.y/2)
			arrows[0].rotation_degrees = 180
	
	
	
	#if move_weight < 1:
	#	move_weight += 0.1
	
	#for i in 4:
	#	arrows[i].global_position = lerp(Vector2(get_viewport().size.x/2, get_viewport().size.y/2 + 200), Vector2(get_viewport().size.x/2, get_viewport().size.y/2 - 200), move_weight)
	
	
	#for i in 4:
	#	arrows[i].move_time += 1
	#	if arrows[i].move_time < 30:
	#		arrows[i].global_position += Vector2(1, 0)
	#	elif arrows[i].move_time < 60
	#		arrows[i].global_position += Vector2(-1, 0)
	#	elif arrows[i].move_time == 60
			
	#		arrows[i].global_position += Vector2(1, 0)
	#	if i == 0: #up
	#		arrows[i].global_position += Vector2(1, 0)
	#var velocity = Vector2.ZERO # The player's movement vector.
	if (timer > 20 && lost == false):
		if Input.is_action_pressed(&"up"):
			if (direction != 0):
				win()
			else:
				lost = true
		if Input.is_action_pressed(&"right"):
			if (direction != 1):
				win()
			else:
				lost = true
		if Input.is_action_pressed(&"down"):
			if (direction != 2):
				win()
			else:
				lost = true
		if Input.is_action_pressed(&"left"):
			if (direction != 3):
				win()
			else:
				lost = true

func win():
	super()

#func balloon_popped():
#	pop_count += 1
#	if pop_count == balloon_amount:
#		win()
