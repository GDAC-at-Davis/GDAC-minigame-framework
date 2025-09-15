extends Control

func _on_start_button_pressed() -> void:
	GameManager.world_manager.load_scene("Home")
	GameManager.world_manager.load_ui("Home")


func _on_select_button_pressed() -> void:
	GameManager.world_manager.load_ui("Selection")
