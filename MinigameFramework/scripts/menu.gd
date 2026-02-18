extends Control

func _on_start_button_pressed() -> void:
	GameManager.world_manager.load_level("Cutscene")


func _on_collection_button_pressed() -> void:
	GameManager.world_manager.load_ui("Collection")
