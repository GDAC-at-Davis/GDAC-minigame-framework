class_name MinigameTester
extends Node2D

@export var minigame_data: MinigameGroupData

var minigame_manager_scene: PackedScene = preload("res://Scenes/MinigameManager.tscn")

func _ready():
	var manager: MinigameManager = minigame_manager_scene.instantiate()
	manager.setup_data(minigame_data)
	add_child(manager)
