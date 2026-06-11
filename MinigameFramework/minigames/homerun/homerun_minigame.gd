extends Minigame
# pitcher/batter sprites used from:
# https://www.spriters-resource.com/nes/baseball/asset/98591/

const BASE_SPEED: float = 450
const PITCH_MIN: float = 0.2
const PITCH_MAX: float = 0.7
const BALL_SPAWN_DELAY = 0.7
const SWING_DELAY = 0.18

@export var pitcher: Node2D
@export var player: Node2D
@export var swing_area: Area2D
@export var swing_collision_shape: CollisionShape2D
@export var swing_rect: RectangleShape2D
@export var debug_box: bool 
@export var fans: Node2D
@export var bat_sounds_player: SoundPlayer
@export var crowd_sounds_player: SoundPlayer

var ball_scene: PackedScene = preload("res://minigames/homerun/ball.tscn")
var ball: Area2D

var speed: float
var hit_random_x: float
var has_pitched: bool = false
var has_swung: bool = false
var has_hit: bool = false
var has_ball_spawned = false


# animation players
var player_animation_player: AnimatedSprite2D
var pitcher_animation_player: AnimatedSprite2D

## This is called once at the start of the minigame.
func start() -> void:
	speed = BASE_SPEED * difficulty
	
	hit_random_x = randf_range(-120, 120)
	
	# Animation initialization
	player_animation_player = swing_area.get_child(1)
	pitcher_animation_player = pitcher.get_child(0)
	
	player_animation_player.animation_finished.connect(_on_player_anim_finished)
	pitcher_animation_player.animation_finished.connect(_on_pitcher_anim_finished)
	
	# Pitch timer
	var pitch_timer = Timer.new()
	add_child(pitch_timer)
	
	pitch_timer.wait_time = randf_range(PITCH_MIN, PITCH_MAX)
	pitch_timer.one_shot = true 
	pitch_timer.timeout.connect(pitch)
	pitch_timer.start()
	
	crowd_sounds_player.play_track(2)
	skip_time = 2.0


## This is called 60 times per second.
func _physics_process(_delta):
	super(_delta)
	
	if has_ball_spawned:
		if has_hit:
			ball.position.y -= speed * _delta
			ball.position.x += hit_random_x * _delta
		else:
			ball.position.y += speed * _delta


func run():
	if Input.is_action_just_pressed("primary"):
		swing()
	
	# If the ball isn't visible, lose
	if ball != null and not has_ended and not get_viewport().get_visible_rect().has_point(ball.global_position):
		lose()
	
	# Draw swing hitbox
	if debug_box:
		var pos: Vector2 = swing_collision_shape.global_position
		var size := swing_rect.size
		var top_left: Vector2 = Vector2(pos.x - (size.x * 0.5), pos.y - (size.y * 0.5))
		var bottom_right: Vector2 = Vector2(pos.x + (size.x * 0.5), pos.y + (size.y * 0.5))
		draw_box(top_left, bottom_right)


func swing() -> void:
	if has_swung:
		return
	
	has_swung = true
	player_animation_player.play("swing")
	
	var swing_delay_timer = Timer.new()
	add_child(swing_delay_timer)
	
	swing_delay_timer.wait_time = SWING_DELAY
	swing_delay_timer.one_shot = true 
	swing_delay_timer.timeout.connect(check_valid_hit)
	swing_delay_timer.start()


func _on_player_anim_finished() -> void:
	if player_animation_player.animation != "default":
		player_animation_player.play("default")


func _on_pitcher_anim_finished() -> void:
	if pitcher_animation_player.animation != "default":
		pitcher_animation_player.play("default")


func win() -> void:
	super()
	
	crowd_sounds_player.play_track(1)
	
	for child: Node2D in fans.get_children():
		if child is Fan:
			child.start_jumping()


func lose() -> void:
	super()
	
	crowd_sounds_player.play_track(0)

## This is called after win() or lose() is called.
func end() -> void:
	pass


func pitch() -> void:
	pitcher_animation_player.play("pitch")
	has_pitched = true
	
	var spawn_timer = Timer.new()
	add_child(spawn_timer)
	spawn_timer.wait_time = BALL_SPAWN_DELAY
	spawn_timer.one_shot = true 
	spawn_timer.timeout.connect(spawn_ball)
	spawn_timer.start()


func spawn_ball() -> void:
	ball = ball_scene.instantiate()
	add_child(ball)
	
	ball.global_position = pitcher.global_position
	var ball_animation_player: AnimatedSprite2D = ball.get_child(1)
	ball_animation_player.play("spin")
	has_ball_spawned = true


func check_valid_hit() -> void:
	
	if ball == null:
		bat_sounds_player.play_track(0)
		lose()
		return
	
	var areas = ball.get_overlapping_areas()
	
	for area in areas:
		if area.name == "SwingArea":
			has_hit = true
			has_won = true
			bat_sounds_player.play_track(1)
			win()
			return
	
	bat_sounds_player.play_track(0)
	
	lose()


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
