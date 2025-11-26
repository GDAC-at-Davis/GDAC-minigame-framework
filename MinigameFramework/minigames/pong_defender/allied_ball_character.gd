extends CharacterBody2D

var _x_vel : float = 0.0
var _y_vel : float = 0.0

func set_vel(x, y):
	_x_vel = x
	_y_vel = y

func _physics_process(delta: float) -> void:
	velocity = Vector2(_x_vel, _y_vel)
	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	match area.get_parent().name:
		"LeftWall":
			_x_vel *= -1
		"RightWall":
			_x_vel *= -1
		"BallCharacter":
			area.get_parent().queue_free()
		_:
			pass
