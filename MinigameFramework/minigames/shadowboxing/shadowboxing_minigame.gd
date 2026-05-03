@tool
extends Minigame

var arrow_packed_scene: PackedScene = preload("res://minigames/shadowboxing/arrow.tscn")
var boxer_scene: PackedScene = preload("res://minigames/shadowboxing/boxer.tscn")
var arrows: Array[Area2D]
var direction: int = 0
var move_weight: float = 0.0
var lost: bool = false
var delay: float = 2.0
var speed: float = 0.2
@onready var blink_timer = $Timer

#@export var idle_curve: Curve
#@export var bob_speed: int = 10
#@export var movement_curve: Curve
@export var pause_frame: int = 15  # The frame number to pause on (Remember: Frame 1 is actually 0!)
@export var pause_duration: float = 3.5  # How many seconds to pause for
var has_paused_this_punch: bool = false  # To stop it from pausing endlessly if it loops

# 0: up, 1: right, 2: down, 3: left (think of compass, never eat soggy waffles!)
@onready var boxer_sprite = $Boxer/AnimatedSprite2D
@onready var particles: GPUParticles2D = $BalloonParticles

func start():
	# Reset variables
	arrows.clear()
	# Adjust for difficulty
	countdown_time /= difficulty
	delay /= difficulty
	
	await get_tree().create_timer(2.0).timeout
	get_node("Boxer").bobbing = false
	
	# Spawn the arrow
	var arrow: Area2D = arrow_packed_scene.instantiate()
	add_child(arrow)
	arrows.append(arrow)
	direction = 3
	#direction = randi_range(0, 3)
	if direction == 0:
		arrows[0].global_position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2 - 200)
		arrows[0].rotation_degrees = 270
	elif direction == 1:
		arrows[0].global_position = Vector2(get_viewport().size.x/2 + 400, get_viewport().size.y/2)
		arrows[0].rotation_degrees = 0
	elif direction == 2:
		boxer_sprite.scale = Vector2(4, 4)
		
		boxer_sprite.play("bottom_punch")
		arrows[0].global_position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2 + 200)
		arrows[0].rotation_degrees = 90
	elif direction == 3:
		boxer_sprite.play("left_punch")
		boxer_sprite.frame_changed.connect(_on_frame_changed)

		arrows[0].global_position = Vector2(get_viewport().size.x/2 - 400, get_viewport().size.y/2)
		arrows[0].rotation_degrees = 180
	# start timer for blinks
	blink_timer.start()

var time: float = 0
var dir: int = 1

func run():
	if arrows.is_empty():
		return
	if !lost:
		speed /= difficulty
		
		if direction == 0:
			arrows[0].global_position -= Vector2(0, speed)
		elif direction == 1:
			arrows[0].global_position += Vector2(speed, 0)
		elif direction == 2:
			arrows[0].global_position += Vector2(0, speed)
		elif direction == 3:
			arrows[0].global_position -= Vector2(speed, 0)
			boxer_sprite.pause()
			await get_tree().create_timer(0.001, false).timeout
			boxer_sprite.play("left_punch")
		if Input.is_action_pressed(&"up"):
			remove_arrow(arrows)
			boxer_sprite.stop()
			if (direction != 0):
				win()
			else:
				lose()
		if Input.is_action_pressed(&"right"):
			remove_arrow(arrows)
			boxer_sprite.stop()
			if (direction != 1):
				win()
			else:
				lose()
		if Input.is_action_pressed(&"down"):
			remove_arrow(arrows)
			boxer_sprite.stop()
			if (direction != 2):
				win()
			else:
				lose()
		if Input.is_action_pressed(&"left"):
			remove_arrow(arrows)
			boxer_sprite.stop()
			if (direction != 3):
				win()
			else:
				lose()
				
				
	#print_debug(countdown_timer.time_left)
	
func remove_arrow(arrows_to_remove):
	blink_timer.stop()
	for arrow in arrows_to_remove:
		if arrow in arrows:
			arrows.erase(arrow)
		if is_instance_valid(arrow):
			arrow.queue_free()
	
func win():
	super()
	show_message("You won!")
	await $MessageTimer.timeout
	
func show_message(text):
	$Message.text = text;
	$Message.show();
	$MessageTimer.start()
	
func lose():
	lost = true
	super()
	show_message("You lost!")
	await $MessageTimer.timeout
	
func _on_timer_timeout() -> void:
	for arrow in arrows:
		if is_instance_valid(arrow):
			arrow.visible = !arrow.visible
func _on_frame_changed() -> void:
	if boxer_sprite.animation == "left_punch" and boxer_sprite.frame == pause_frame and not has_paused_this_punch:
		
		# 2. Lock it so it doesn't trigger again on accident
		has_paused_this_punch = true 
		
		# 3. Freeze the animation on this exact frame
		boxer_sprite.pause() 
		
		# 4. Wait for the desired amount of time
		await get_tree().create_timer(pause_duration).timeout 
		
		# 5. Resume the animation!
		boxer_sprite.play()
	
