@tool
extends Area2D

@export var idle_curve: Curve
@export var bob_speed: int = 10

var time: float = 0
var dir: int = 1

func _process(delta):
	
	time += delta * dir
		
	#$AnimatedSprite2D.position.x = idle_curve.sample(time) * bob_speed
	
	$AnimatedSprite2D.position.y = idle_curve.sample(time) * bob_speed
	
	if time > 1:
		dir = -1
	elif time < 0:
		dir = 1
	
	time = clamp(time, 0, 1)
