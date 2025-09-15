extends Node

var main_scene: Node
var world_manager: WorldManager
var minigame_manager: MinigameManager

var _world_manager_scene: PackedScene = preload("res://scenes/WorldManager.tscn")
var _minigame_manager_scene: PackedScene = preload("res://scenes/MinigameManager.tscn")

func _ready():
	world_manager = _world_manager_scene.instantiate()
	minigame_manager = _minigame_manager_scene.instantiate()

func switch_to_minigames(minigame_data : MinigameGroupData, endless: bool = false):
	main_scene.remove_child(world_manager)
	main_scene.add_child(minigame_manager)
	minigame_manager.start(minigame_data, endless)

func switch_to_world():
	main_scene.remove_child(minigame_manager)
	main_scene.add_child(world_manager)
