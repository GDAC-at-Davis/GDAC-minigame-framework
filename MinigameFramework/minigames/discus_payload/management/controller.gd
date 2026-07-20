extends Node2D

@export var player : CharacterBody2D
@export var payload : CharacterBody2D
@export var charge_progress_bar : ProgressBar

## the curve for how the velocity changes in release to the keys
@export var speed_build_up_curve : Curve

## track if holding mouse 
enum State {START, SPINNING, RELEASED}
var state : State

## track change in angle 
var rotational_speed : float 
var old_angle : float

# global variables for spin charge
var charge : float
@export var charge_to_speed_graph : Curve

func _ready() -> void:
	state = State.SPINNING
	old_angle = 0

func _physics_process(delta: float) -> void:
	if state == State.SPINNING:
		# update the payload position
		payload.global_position = player.find_child("HoldPosition").global_position
		
		if Input.is_action_pressed("up"):
			if player.rotational_speed > 0.0:
				player.rotational_speed += speed_build_up_curve.sample(absf(player.rotational_speed)) * delta
			else:
				player.rotational_speed += 45.0 * delta
				charge -= 0.5 * delta
		elif Input.is_action_pressed("down"):
			if player.rotational_speed < 0.0: 
				player.rotational_speed -= speed_build_up_curve.sample(absf(player.rotational_speed)) * delta
			else:
				player.rotational_speed -= 45.0 * delta
				charge -= 0.5 * delta
		 
		# power up charge
		charge += absf(player.rotational_speed) * delta * 0.03
		charge -= 0.3 * delta
		
		if charge < 0: 
			charge = 0
		elif charge > 1: 
			charge = 1
		
		charge_progress_bar.value = charge
	
		if Input.is_action_just_pressed("primary"):
			state = State.RELEASED
			var dir : Vector2 = player.find_child("HoldPosition").global_position - player.global_position
			payload.velocity = dir * payload.speed * charge_to_speed_graph.sample(charge)
			player.rotational_speed = 0
			
	elif state == State.RELEASED:
		payload.move_and_slide() 
	
	"""
	if state == State.START and Input.is_action_just_pressed("primary"):
		state = State.SPINNING
	
	elif state == State.SPINNING and Input.is_action_just_released("primary"):
		state = State.RELEASED
		var dir : Vector2 = player.find_child("HoldPosition").global_position - player.global_position
		payload.velocity = dir * payload.speed * charge_to_speed_graph.sample(charge)
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
		
		# power up charge
		charge += absf(player.rotational_speed) * delta * 0.05
		charge -= 0.25 * delta
		
		if charge < 0: 
			charge = 0
		elif charge > 1: 
			charge = 1
		
		charge_progress_bar.value = charge
	
	elif state == State.RELEASED:
		payload.move_and_slide()
	"""
