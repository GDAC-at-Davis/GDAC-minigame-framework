extends Area2D

@export var speed: float = 800.0

func _physics_process(delta):
	var dir = 0.0
	
	if Input.is_action_pressed("ui_left"):
		dir -= 1
	if Input.is_action_pressed("ui_right"):
		dir += 1

	position.x += dir * speed * delta
	
	# keep basket within the screen 
	var viewport := get_viewport().get_visible_rect()
	position.x = clamp(position.x, 0.0, viewport.size.x)
