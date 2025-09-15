class_name MinigameTester
extends Node2D

@export var minigame_data: MinigameGroupData

var minigame_manager_scene: PackedScene = preload("res://scenes/MinigameManager.tscn")

func _ready():
	var manager: MinigameManager = minigame_manager_scene.instantiate()
	add_child(manager)
	manager.start(minigame_data)
