extends Minigame
@onready var sfx_square: AudioStreamPlayer = $sfx_circle/sfx_square
@onready var sfx_circle: AudioStreamPlayer = $sfx_circle

# Preload scenes
var circle_scene: PackedScene = preload("res://minigames/circle_clicker/circle.tscn")
var square_scene: PackedScene = preload("res://minigames/circle_clicker/square.tscn")
var triangle_scene: PackedScene = preload("res://minigames/circle_clicker/triangle.tscn")
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

	spawn_single_circle()

func spawn_shape():
	var shape: Area2D
	var screen_size = get_viewport().get_visible_rect().size
	
	
	## 50% chance for triangle or square
	if randf() > 0.5:
		shape = square_scene.instantiate()
		shape.modulate = Color(randf(), randf(), randf())
		#total_circles += 1 # Count the circle!
	else:
		shape = triangle_scene.instantiate()
		shape.modulate = Color(randf(), randf(), randf())
		
	
	add_child(shape)
	# Random position with padding so they don't spawn on the edge
	shape.global_position = Vector2(
		randf_range(60, screen_size.x - 60),
		randf_range(60, screen_size.y - 100)
	)

func spawn_single_circle():
	var shape = circle_scene.instantiate()
	shape.modulate = Color(randf(), randf(), randf())
	total_circles += 1
	add_child(shape)
	var screen_size = get_viewport().get_visible_rect().size
	shape.global_position = Vector2(randf_range(60, screen_size.x - 60),
		randf_range(60, screen_size.y - 100))

# Called by circle.gd
func circle_clicked():
	sfx_circle.play()
	circles_popped += 1
	# Check win condition
	if circles_popped >= total_circles:
		win()

# Called by square.gd
func square_clicked():
	sfx_square.play()
	print("Hit a square!") 
	
func trig_clicked():
	sfx_square.play()
	print("Hit a triangle!") 

func win():
	super() # Call the parent win function
