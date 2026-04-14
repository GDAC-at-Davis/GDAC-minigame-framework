extends Node2D

@export var player : CharacterBody2D
@export var payload : RigidBody2D

## track if holding mouse 
var holding_mouse : bool 

## track the position of the mouse 
var mouse_pos : Vector2 
var direction_of_mouse : Vector2

## tracks how long the player has been holding down the position
var time_held_down : float 

func _physics_process(delta: float) -> void:
	if not holding_mouse and Input.is_action_just_pressed("primary"):
		holding_mouse = true
		time_held_down = 0 
		# lock the player onto the mouse position 
		#"""
		var new_mouse_pos : Vector2 = get_viewport().get_mouse_position()
		var hold_pos : Vector2 = player.get_node("HoldPosition").global_position
		var new_direction_of_mouse : Vector2 = new_mouse_pos - player.global_position
		var angle_of_rotation : float = acos(hold_pos.dot(new_direction_of_mouse) / (new_direction_of_mouse.length() * hold_pos.length()))
		if not is_nan(angle_of_rotation):
			player.rotate(angle_of_rotation)#angle_of_rotation)
		print(angle_of_rotation)
		#"""
		
		# do this to prevent bug where detect movement on click
		mouse_pos = get_viewport().get_mouse_position()
	elif holding_mouse and Input.is_action_just_released("primary"):
		holding_mouse = false
		
		# lauch the payload
		#var direction : Vector2 = player.find_child("HoldPosition").global_position - player.global_position
		#payload.apply_impulse(player.angular_velocity * direction.normalized() * 20)
		
	if holding_mouse:
		var new_mouse_pos : Vector2 = get_viewport().get_mouse_position()
		var new_direction_of_mouse : Vector2 = new_mouse_pos - player.global_position
		#var angle_of_rotation : float = acos(new_direction_of_mouse.dot(direction_of_mouse) / (new_direction_of_mouse.length() * direction_of_mouse.length()))
		var angle_of_rotation : float = acos(direction_of_mouse.dot(new_direction_of_mouse) / (new_direction_of_mouse.length() * direction_of_mouse.length()))
		if not is_nan(angle_of_rotation):
			player.rotate(angle_of_rotation)#angle_of_rotation)
		direction_of_mouse = new_direction_of_mouse
