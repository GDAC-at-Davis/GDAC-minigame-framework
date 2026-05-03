@tool
extends Area2D

@export var idle_curve_x: Curve
@export var idle_curve_y: Curve
@export var bob_speed: int = 10

var time: float = 0
var dir: int = 1

var bobbing: bool = true

func _process(delta):
	if bobbing:
		time += (delta * dir) * 1.2
			
		$AnimatedSprite2D.position.x = idle_curve_x.sample(time) * bob_speed
		$AnimatedSprite2D.position.y = idle_curve_y.sample(time) * bob_speed
		
		if time > 1:
			dir = -1
		elif time < 0:
			dir = 1
		
		time = clamp(time, 0, 1)
