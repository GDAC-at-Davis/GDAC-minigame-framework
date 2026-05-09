extends Node2D

@export var player : CharacterBody2D
@export var payload : CharacterBody2D


## track if holding mouse 
enum State {START, SPINNING, RELEASED}
var state : State

## track change in angle 
var rotational_speed : float 
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
		payload.velocity = dir * payload.speed * abs(player.rotational_speed)  #* player.
		player.rotational_speed = 0
	
	elif state == State.SPINNING:
		# update the payload position
		payload.global_position = player.find_child("HoldPosition").global_position
		
		# get the information on the mouse position, direction, and angle
		var mouse_pos : Vector2 = get_viewport().get_mouse_position()
		var mouse_dir : Vector2 = mouse_pos - player.global_position
		var mouse_angle : float
		mouse_angle = acos(mouse_dir.dot(Vector2.DOWN) / (mouse_dir.length() * Vector2.DOWN.length()))
		if mouse_dir.x > 0:
			mouse_angle = 2 * PI - mouse_angle
		
		var mouse_rotational_speed = (mouse_angle - old_angle) / delta
		old_angle = mouse_angle
		
		print(mouse_angle, " ", old_angle, " ", delta, " ", mouse_rotational_speed)
		
		# calculate the new rotation speed
		player.rotational_speed = mouse_rotational_speed
		"""
			
		player.rotation = mouse_angle
		
		# move the payload 
		payload.global_position = player.find_child("HoldPosition").global_position
		
		# calculate speed
		angle_change_speed = (mouse_angle - old_angle) / delta
		player.angle_change_speed = angle_change_speed
		old_angle = mouse_angle
		"""
	
	elif state == State.RELEASED:
		payload.move_and_slide()
