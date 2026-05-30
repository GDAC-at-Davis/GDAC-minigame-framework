extends Control

func _on_start_button_pressed() -> void:
	GameManager.world_manager.progress_story()


func _on_collection_button_pressed() -> void:
	GameManager.world_manager.load_ui("Collection")
