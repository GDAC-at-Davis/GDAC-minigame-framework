extends CharacterBody2D

## the amonut the angle changes per second
var rotational_speed : float = 0.0
@export var drag : float = 1.0

func _physics_process(delta: float) -> void:
	var full_rotation = rotation + (rotational_speed * delta)
	
	if full_rotation > 2 * PI: 
		var fac : float = full_rotation / (2 * PI)
		var reminders : float = fac - floorf(fac)
		rotation = reminders * (2 * PI)
	else: 
		rotation = full_rotation
	

	"""
	var instant_drag := sqrt(drag) * delta

	# apply drag
	if rotational_speed < -1 * instant_drag:
		rotational_speed += instant_drag
	elif rotational_speed > instant_drag: 
		rotational_speed -= instant_drag

	if absf(rotational_speed) < 0.1:
		rotational_speed = 0.0 
	"""

"""
## the max torque that is applied 
@export var max_speed : float

## the curve modifying the torque based on distance mouse travels 
@export var torque_curve : Curve

## the curve that modifyis the torque based on how long the player held down the button
@export var time_modifier : Curve
"""
