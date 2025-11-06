extends Area2D

var _mouse_entered: bool = false

func _mouse_enter():
	_mouse_entered = true
	
func _mouse_exit():
	_mouse_entered = false

func _process(delta):
	if Input.is_action_just_pressed("primary") and _mouse_entered:
			get_parent().balloon_popped()
			queue_free()
