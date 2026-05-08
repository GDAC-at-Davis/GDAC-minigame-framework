extends Node2D

@export var player : CharacterBody2D
@export var payload : CharacterBody2D

## track if holding mouse 
enum State {START, SPINNING, RELEASED}
var state : State

## track change in angle 
var angle_change_speed : float 
var old_angle : float

func _ready() -> void:
	state = State.START
	old_angle = 0

func _physics_process(delta: float) -> void:
	if state == State.START and Input.is_action_just_pressed("primary"):
		state = State.SPINNING
	
	elif state == State.SPINNING and Input.is_action_just_released("primary"):
		state = State.RELEASED
		var dir : Vector2 = player.find_child("HoldPosition").global_position - player.global_position
		payload.velocity = dir * payload.speed * abs(angle_change_speed)  #* player.
		player.angle_change_speed = 0
	
	elif state == State.SPINNING:
		# get the information on the mouse position, direction, and angle
		var mouse_pos : Vector2 = get_viewport().get_mouse_position()
		var mouse_dir : Vector2 = mouse_pos - player.global_position
		var mouse_angle : float
		mouse_angle = acos(mouse_dir.dot(Vector2.DOWN) / (mouse_dir.length() * Vector2.DOWN.length()))
		if mouse_dir.x > 0:
			mouse_angle = 2 * PI - mouse_angle
			
		player.rotation = mouse_angle
		
		# move the payload 
		payload.global_position = player.find_child("HoldPosition").global_position
		
		# calculate speed
		angle_change_speed = (mouse_angle - old_angle) / delta
		player.angle_change_speed = angle_change_speed
		old_angle = mouse_angle
	
	elif state == State.RELEASED:
		payload.move_and_slide()
		
"""
## tracks how long the player has been holding down the position
var time_held_down : float 

func _physics_process(delta: float) -> void:
	if not holding_mouse and Input.is_action_just_pressed("primary"):
		holding_mouse = true
		time_held_down = 0 
		# lock the player onto the mouse position 
		
		var new_mouse_pos : Vector2 = get_viewport().get_mouse_position()
		var hold_pos : Vector2 = player.get_node("HoldPosition").global_position
		var new_direction_of_mouse : Vector2 = new_mouse_pos - player.global_position
		var angle_of_rotation : float = acos(hold_pos.dot(new_direction_of_mouse) / (new_direction_of_mouse.length() * hold_pos.length()))
		if not is_nan(angle_of_rotation):
			player.rotate(angle_of_rotation)#angle_of_rotation)
		print(angle_of_rotation) 
		
		# do this to prevent bug where detect movement on click
		mouse_pos = get_viewport().get_mouse_position()
	elif holding_mouse and Input.is_action_just_released("primary"):
		holding_mouse = false
		
		# lauch the payload
		#var direction : Vector2 = player.find_child("HoldPosition").global_position - player.global_position
		#payload.apply_impulse(player.angular_velocity * direction.normalized() * 20)

"""
