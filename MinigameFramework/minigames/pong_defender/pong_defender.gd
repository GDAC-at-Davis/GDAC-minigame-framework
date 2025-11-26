extends Minigame

var _ball_scene: PackedScene = preload("res://minigames/pong_defender/ball.tscn")

func start() -> void:
	_spawn_balls()

func _spawn_balls() -> void:
	for i in range(3):
		var ball: Node2D = _ball_scene.instantiate()
		add_child(ball)
		var _x_pos :float = randf_range(100, 1200)
		var _y_pos :float = randf_range(65, 200)
		ball.global_position = Vector2(_x_pos, _y_pos)
	
