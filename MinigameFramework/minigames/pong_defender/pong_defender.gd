class_name PongDefender
extends Minigame

signal ball_destroyed()

var _DEFAULT_BALLS = 3

var _ball_scene: PackedScene = preload("res://minigames/pong_defender/ball.tscn")
var _total_balls: int = _DEFAULT_BALLS

func start() -> void:
	ball_destroyed.connect(_ball_destroyed_handler)
	
	_spawn_balls()

func _spawn_balls() -> void:
	# calculate the number of balls based on difficulty level
	var _num_balls: int = _DEFAULT_BALLS
	_num_balls += ((difficulty - 1) / 0.1) as int
	
	# set the total number 
	_total_balls = _num_balls
	
	# generate the balls
	for i in range(_num_balls):
		var ball: Ball = _ball_scene.instantiate() as Ball

		add_child(ball)
		
		# set position
		var _x_pos :float = randf_range(100, 1200)
		var _y_pos :float = randf_range(65, 200)
		ball.global_position = Vector2(_x_pos, _y_pos)
		
		# set velocity
		ball.set_vel(randf_range(-100, 100), randf_range(200, 300))

# subtract the number of balls
func _ball_destroyed_handler():
	_total_balls -= 1
	if _total_balls == 0:
		win()
