extends Area2D

func _ready():
	input_event.connect(_on_input_event)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("primary") and event.pressed:
			get_parent().balloon_popped()
			queue_free()
