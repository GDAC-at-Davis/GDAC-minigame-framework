extends Control

@onready var god_scene = get_parent().get_parent()

func _on_start_button_pressed() -> void:
	god_scene.load_scene("Home")
