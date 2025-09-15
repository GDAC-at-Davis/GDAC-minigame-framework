extends Node

var main_scene: Node
var world_manager: WorldManager
var minigame_manager: MinigameManager

var minigame_collection: Array[MinigameInfo]

var _minigame_folder_path: String = "res://minigames/"
var _world_manager_scene: PackedScene = preload("res://scenes/WorldManager.tscn")
var _minigame_manager_scene: PackedScene = preload("res://scenes/MinigameManager.tscn")

func _ready():
	world_manager = _world_manager_scene.instantiate()
	minigame_manager = _minigame_manager_scene.instantiate()
	_load_info_from_disk(_minigame_folder_path)

func switch_to_minigames(minigame_data : MinigameGroupData, endless: bool = false):
	main_scene.remove_child(world_manager)
	main_scene.add_child(minigame_manager)
	minigame_manager.start(minigame_data, endless)

func switch_to_world():
	main_scene.remove_child(minigame_manager)
	main_scene.add_child(world_manager)


func _load_info_from_disk(path: String):
	var dir_access = DirAccess.open(path)
	for dir_name in dir_access.get_directories():
		_load_info_from_disk(path + "/" + dir_name)
	for file_name in dir_access.get_files():
		if file_name.get_extension() == "tres":
			var info_path = path + "/" + file_name
			var info : MinigameInfo = ResourceLoader.load(info_path)
			if info:
				minigame_collection.append(info)
