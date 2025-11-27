class_name Main
extends Node

func _ready() -> void:
	#var scene = load("res://minigames/homerun/homerun.tscn")
	#var instance = scene.instantiate()
	#add_child(instance)
	#print("Instance added, inside tree?", instance.is_inside_tree())
	
	GameManager.main_scene = self
	GameManager.switch_to_world()
	GameManager.world_manager.load_ui("Menu")
