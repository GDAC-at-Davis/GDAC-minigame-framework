class_name AvalanchePlayer
extends CharacterBody2D

@export var max_speed: float = 420.0
@export var acceleration: float = 1200.0
@export var friction: float = 1400.0
@export var bounds_left: float = 80.0
@export var bounds_right: float = 1200.0

var input_enabled: bool = true

func reset_motion() -> void:
	velocity = Vector2.ZERO
	input_enabled = true


func disable_input() -> void:
	input_enabled = false
	velocity = Vector2.ZERO


func _physics_process(delta: float) -> void:
	var dir: float = 0.0
	if input_enabled:
		if Input.is_action_pressed("left"):
			dir -= 1.0
		if Input.is_action_pressed("right"):
			dir += 1.0
		if dir != 0.0:
			velocity.x = move_toward(velocity.x, dir * max_speed, acceleration * delta)
		else:
			velocity.x = move_toward(velocity.x, 0.0, friction * delta)
	else:
		velocity.x = move_toward(velocity.x, 0.0, friction * delta)
	move_and_slide()
	global_position.x = clamp(global_position.x, bounds_left, bounds_right)
