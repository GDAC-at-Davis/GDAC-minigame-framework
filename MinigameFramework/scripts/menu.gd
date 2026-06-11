extends Control

func _on_start_button_pressed() -> void:
	GameManager.switch_scenes(load("res://scenes/overworld.tscn"))
	queue_free()


func _on_collection_button_pressed() -> void:
	GameManager.switch_scenes(load("res://scenes/minigame_collection.tscn"))
	queue_free()
