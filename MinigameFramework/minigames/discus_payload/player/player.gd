extends CharacterBody2D

## the amonut the angle changes per second
@export var rotational_speed : float = 0.0

func _physics_process(delta: float) -> void:
	var full_rotation = rotation + (rotational_speed * delta)
	
	if full_rotation > 2 * PI: 
		var fac : float = full_rotation / (2 * PI)
		var reminders : float = fac - floorf(fac)
		rotation = reminders * (2 * PI)
	else: 
		rotation = full_rotation
	
	#rotation = full_rotation % rotation

"""
## the max torque that is applied 
@export var max_speed : float

## the curve modifying the torque based on distance mouse travels 
@export var torque_curve : Curve

## the curve that modifyis the torque based on how long the player held down the button
@export var time_modifier : Curve
"""
