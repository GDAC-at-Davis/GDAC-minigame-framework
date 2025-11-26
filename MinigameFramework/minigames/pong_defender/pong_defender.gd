extends Minigame

var _ball_scene: PackedScene = preload("res://minigames/pong_defender/ball.tscn")

func start() -> void:
	_spawn_balls()

func _spawn_balls() -> void:
	var _num_balls:int = 3
	print((difficulty - 1) / 0.1)
	_num_balls += ((difficulty - 1) / 0.1) as int
	for i in range(_num_balls):
		var ball: Ball = _ball_scene.instantiate() as Ball
		print(ball.get_script())
		add_child(ball)
		var _x_pos :float = randf_range(100, 1200)
		var _y_pos :float = randf_range(65, 200)
		ball.global_position = Vector2(_x_pos, _y_pos)
		ball.set_vel(randf_range(-100, 100), randf_range(200, 300))
	
