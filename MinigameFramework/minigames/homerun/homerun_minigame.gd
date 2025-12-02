extends Minigame

const BASE_SPEED: float = 450
const PITCH_MIN: float = 0.5
const PITCH_MAX: float = 1.2

@export var pitcher: Node2D
@export var player: Node2D
@export var swing_area: Area2D
@export var swing_collision_shape: CollisionShape2D
@export var swing_rect: RectangleShape2D
@export var debug_box_on: bool 
@export var fans: Node2D

var ball_scene: PackedScene = preload("res://minigames/homerun/ball.tscn")
var ball: Area2D

var speed: float
var has_pitched: bool = false
var has_swung: bool = false
var has_hit: bool = false


## This is called once at the start of the minigame.
func start() -> void:
	print("starting homerun")
	speed = BASE_SPEED * difficulty
	
	var pitch_timer = Timer.new()
	add_child(pitch_timer)
	
	pitch_timer.wait_time = randf_range(PITCH_MIN, PITCH_MAX)
	pitch_timer.one_shot = true 
	pitch_timer.timeout.connect(pitch)
	pitch_timer.start()


## This is called 60 times per second.
func _physics_process(_delta):
	super(_delta)
	
	if has_pitched:
		if has_hit:
			ball.position.y -= speed * _delta
		else:
			ball.position.y += speed * _delta


func run():
	if not has_swung and Input.is_action_just_pressed("primary"):
		has_swung = true
		if is_valid_hit():
			print("hit!")
			has_hit = true
			has_won = true
			win()
		else:
			print("miss!")
			lose()
	
	# If the ball isn't visible, lose
	if ball != null and not get_viewport().get_visible_rect().has_point(ball.global_position):
		lose()
	
	# Draw swing hitbox
	if debug_box_on:
		var pos: Vector2 = swing_collision_shape.global_position
		var size := swing_rect.size
		var top_left: Vector2 = Vector2(pos.x - (size.x * 0.5), pos.y - (size.y * 0.5))
		var bottom_right: Vector2 = Vector2(pos.x + (size.x * 0.5), pos.y + (size.y * 0.5))
		draw_box(top_left, bottom_right)


func win() -> void:
	super()
	for fan: Node2D in fans.get_children():
		if fan is Fan:
			fan.start_jumping()


## This is called after win() or lose() is called.
func end() -> void:
	pass


# Create ball
func pitch() -> void:
	ball = ball_scene.instantiate()
	add_child(ball)
	ball.global_position = pitcher.global_position
	has_pitched = true


func is_valid_hit() -> bool:
	var areas = ball.get_overlapping_areas()
	
	for area in areas:
		if area.name == "SwingArea":
			return true
	return false



# Draws a box between two Vector2s
func draw_box(top_left: Vector2, bottom_right: Vector2) -> void:
	# Create a Line2D node
	var line := Line2D.new()
	line.width = 2.0
	line.default_color = Color.BLACK
	
	# Set the rectangle points
	var points = [
		top_left,
		Vector2(top_left.x, bottom_right.y),
		bottom_right,
		Vector2(bottom_right.x, top_left.y),
		top_left  # close the rectangle
	]
	line.points = points
	
	# Add it to the current node
	add_child(line)
