extends Node2D

@export var player : RigidBody2D
@export var payload : RigidBody2D

## track if holding mouse 
var holding_mouse : bool 

## track the position of the mouse 
var mouse_pos : Vector2 

## tracks how long the player has been holding down the position
var time_held_down : float 

func _physics_process(delta: float) -> void:
	if not holding_mouse and Input.is_action_just_pressed("primary"):
		holding_mouse = true
		time_held_down = 0 
		# do this to prevent bug where detect movement on click
		mouse_pos = get_viewport().get_mouse_position()
	elif holding_mouse and Input.is_action_just_released("primary"):
		holding_mouse = false
		
		# lauch the payload
		var direction : Vector2 = player.find_child("HoldPosition").global_position - player.global_position
		payload.apply_impulse(player.angular_velocity * direction.normalized() * 20)
		
	if holding_mouse:
		# decide speed 
		var new_mouse_pos : Vector2 = get_viewport().get_mouse_position()
		var change_in_mouse_pos := new_mouse_pos - mouse_pos
		mouse_pos = new_mouse_pos
		
		var mouse_pos_to_torque = player.torque_curve.sample(change_in_mouse_pos.length())
		var time_mod = player.time_modifier.sample(min(2.0, time_held_down))
		
		player.apply_torque(change_in_mouse_pos.length() * mouse_pos_to_torque * time_mod * player.max_speed)
		
		# move the payload
		payload.global_position = player.find_child("HoldPosition").global_position
		
		# increase time 
		time_held_down += delta
