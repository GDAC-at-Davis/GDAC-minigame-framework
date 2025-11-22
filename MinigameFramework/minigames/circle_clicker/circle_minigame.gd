extends Minigame

# Preload scenes
var circle_scene: PackedScene = preload("res://minigames/circle_clicker/circle.tscn")
var square_scene: PackedScene = preload("res://minigames/circle_clicker/square.tscn")

# Game State
var circles_popped: int = 0
var total_circles: int = 0
var base_object_count: int = 5

func start():
	# 1. RESET VARIABLES 
	circles_popped = 0
	total_circles = 0
	
	for child in get_children():
		if child is Area2D:
			child.queue_free()

	var object_count = base_object_count * max(1, roundi(difficulty*4))
	
	for i in range(object_count):
		spawn_shape()
		#
	## If RNG gave us 0 circles, spawn at least one so the game is playable
	#if total_circles == 0:
	spawn_single_circle()

func spawn_shape():
	var shape: Area2D
	var screen_size = get_viewport().get_visible_rect().size
	
	## 50% chance for triangle or square
	if randf() > 0.5:
		shape = square_scene.instantiate()
		#total_circles += 1 # Count the circle!
	else:
		shape = square_scene.instantiate()
	
	add_child(shape)
	# Random position with padding so they don't spawn on the edge
	shape.global_position = Vector2(
		randf_range(60, screen_size.x - 60),
		randf_range(60, screen_size.y - 60)
	)

func spawn_single_circle():
	var shape = circle_scene.instantiate()
	total_circles += 1
	add_child(shape)
	var screen_size = get_viewport().get_visible_rect().size
	shape.global_position = Vector2(randf_range(60, screen_size.x - 60),
		randf_range(60, screen_size.y - 60))

# Called by circle.gd
func circle_clicked():
	circles_popped += 1
	# Check win condition
	if circles_popped >= total_circles:
		win()

# Called by square.gd
func square_clicked():
	# Force the minigame to end/fail if a square is hit
	# If you don't have a lose() function, we can just print for now
	print("Hit a square!") 

func win():
	super() # Call the parent win function
