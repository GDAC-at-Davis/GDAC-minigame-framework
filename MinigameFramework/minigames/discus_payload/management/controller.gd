extends Node2D

@export var player : RigidBody2D

## track if holding mouse 
var holding_mouse : bool 

## track the position of the mouse 
var mouse_pos : Vector2 

func _physics_process(delta: float) -> void:
	if not holding_mouse and Input.is_action_just_pressed("primary"):
		holding_mouse = true
	elif holding_mouse and Input.is_action_just_released("primary"):
		holding_mouse = false
		
	if holding_mouse:
		var new_mouse_pos : Vector2 = get_viewport().get_mouse_position()
		var change_in_mouse_pos := new_mouse_pos - mouse_pos
		mouse_pos = new_mouse_pos
		player.apply_torque(mouse_pos.length() * player.speed)
