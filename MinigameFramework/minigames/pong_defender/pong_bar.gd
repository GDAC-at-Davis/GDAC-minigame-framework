extends CharacterBody2D

# assets provided by: https://godotengine.org/asset-library/asset/121

var _ball_scene: PackedScene = preload("res://minigames/pong_defender/allied_ball.tscn")

var _speed:float = 2000.0 # units per second

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed('left') and Input.is_action_pressed('right'):
		velocity = Vector2(0,0)
	elif Input.is_action_pressed('left'):
		velocity = Vector2(-_speed, 0)
	elif Input.is_action_pressed('right'):
		velocity = Vector2(_speed, 0)
	else:
		velocity = Vector2(0,0)
		
	if Input.is_action_just_pressed('up'):
		var ball: AlliedBall = _ball_scene.instantiate() as AlliedBall
		get_parent().add_child(ball)
		ball.global_position = Vector2(global_position.x, global_position.y - 100)
		ball.set_vel(0, -200)
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	area.get_parent().get_parent().queue_free()
	area.queue_free()
	print("area enetered:" + area.name)
	pass # Replace with function body.
