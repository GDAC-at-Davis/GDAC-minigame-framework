extends CharacterBody2D

var _x_vel : float = 0.0
var _y_vel : float = 0.0


func _ready() -> void:
	_x_vel = randf_range(-500, -200)
	_y_vel = 500

func _physics_process(delta: float) -> void:
	velocity = Vector2(_x_vel, _y_vel)
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	match area.get_parent().name:
		"LeftWall":
			_x_vel *= -1
		"RightWall":
			_x_vel *= -1
		_:
			pass
	print("ball: " + area.get_parent().name)
