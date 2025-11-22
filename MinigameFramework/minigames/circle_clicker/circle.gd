extends Area2D

var _mouse_entered: bool = false

func _mouse_enter():
	_mouse_entered = true

func _mouse_exit():
	_mouse_entered = false

func _process(delta):
	# Checks if left mouse is clicked while hovering this object
	if Input.is_action_just_pressed("primary") and _mouse_entered:
		# Call the function in the main minigame script
		get_parent().circle_clicked()
		queue_free() # Delete the circle
