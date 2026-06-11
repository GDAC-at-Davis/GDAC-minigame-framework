class_name Main
extends Node

@onready var minigame_manager = $MinigameManager

func _ready() -> void:
	#var scene = load("res://minigames/homerun/homerun.tscn")
	#var instance = scene.instantiate()
	#add_child(instance)
	#print("Instance added, inside tree?", instance.is_inside_tree())
	
	GameManager.main_scene = self
	GameManager.minigame_manager = minigame_manager
	GameManager.switch_scenes(load("res://scenes/menu.tscn"))
