extends CharacterBody2D

# assets provided by: https://godotengine.org/asset-library/asset/121

var _speed:float = 1000.0 # units per second

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed('left') and Input.is_action_pressed('right'):
		velocity = Vector2(0,0)
	elif Input.is_action_pressed('left'):
		velocity = Vector2(-_speed, 0)
	elif Input.is_action_pressed('right'):
		velocity = Vector2(_speed, 0)
	else:
		velocity = Vector2(0,0)
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	area.get_parent().get_parent().queue_free()
	area.queue_free()
	print("area enetered:" + area.name)
	pass # Replace with function body.
