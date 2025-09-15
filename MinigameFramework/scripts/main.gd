class_name Main
extends Node

func _ready() -> void:
	GameManager.main_scene = self
	GameManager.switch_to_world()
	GameManager.world_manager.load_ui("Menu")
