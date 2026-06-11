extends CharacterBody2D

# assets provided by: https://godotengine.org/asset-library/asset/121

var _DEBOUNCE_TIME: float = 0.1 # sec

var _ball_scene: PackedScene = preload("res://minigames/pong_defender/allied_ball.tscn")

var _time_since_press: float = 0.0

var _speed:float = 2000.0 # units per second
#TODO: shoot balls better, win or lose condition
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed('left') and Input.is_action_pressed('right'):
		velocity = Vector2(0,0)
	elif Input.is_action_pressed('left'):
		velocity = Vector2(-_speed, 0)
	elif Input.is_action_pressed('right'):
		velocity = Vector2(_speed, 0)
	else:
		velocity = Vector2(0,0)
		
	_time_since_press += delta
	if Input.is_action_pressed('primary') and _time_since_press > _DEBOUNCE_TIME:
		var ball: AlliedBall = _ball_scene.instantiate() as AlliedBall
		get_parent().add_child(ball)
		ball.global_position = Vector2(global_position.x, global_position.y - 100)
		ball.set_vel(0, -200)
		_time_since_press = 0
	move_and_slide()

# get rid of any balls that hit the bar
func _on_area_2d_area_entered(area: Area2D) -> void:
	area.get_parent().get_parent().queue_free()
	area.queue_free()
	
	# trigger signal
	var pongDefenderParent : PongDefender = get_parent()
	pongDefenderParent.emit_signal("ball_destroyed")
