class_name Pipe
extends Area2D

@export var correct_rotation = 0
# im using gross as hell math for the forward pipes rotation logic
@export var forward_rotation = 1

var _is_correct_rotation: bool = false
var _mouse_entered: bool = false

func _mouse_enter():
	_mouse_entered = true
	
func _mouse_exit():
	_mouse_entered = false

func _process(delta):
	# clamping rots between 0 and 360
	if(rotation_degrees >= 360):
		rotation_degrees = 0
	if(rotation_degrees < 0):
		rotation_degrees = 359
	
	# if pipes are in the correct rotation, it's true
	# the forward_rotation variable is made for the forward pipes. They can be correct in 2
	# different rotations so i just made it so that if the forward pipe is
	# 90 or 270 degrees then its in correct rotation by doing 90 * 3 for all forward pipes
	# and 90 * 1 for the turning pipes
	if(rotation_degrees == correct_rotation or rotation_degrees == correct_rotation * forward_rotation):
		_is_correct_rotation = true
	else:
		_is_correct_rotation = false
		
	if Input.is_action_just_pressed("primary") and _mouse_entered:
		rotation_degrees += 90
		
