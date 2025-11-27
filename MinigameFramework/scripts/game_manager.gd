extends Node

var main_scene: Node
var world_manager: WorldManager
var minigame_manager: MinigameManager
var music_player : AudioStreamPlayer
var currently_playing : String = ""

var minigame_collection: Array[MinigameInfo]

var _minigame_folder_path: String = "res://minigames/"
var _world_manager_scene: PackedScene = preload("res://scenes/world_manager.tscn")
var _minigame_manager_scene: PackedScene = preload("res://scenes/minigame_manager.tscn")

func _ready():
	world_manager = _world_manager_scene.instantiate()
	minigame_manager = _minigame_manager_scene.instantiate()
	_load_info_from_disk(_minigame_folder_path)
	music_player = AudioStreamPlayer.new()
	add_child(music_player)

## Starts the minigame manager with the minigame group data
func switch_to_minigames(minigame_data : MinigameGroupData, endless: bool = false):
	if world_manager.get_parent():
		main_scene.remove_child(world_manager)
	main_scene.add_child(minigame_manager)
	minigame_manager.start(minigame_data, endless)

## Removes the minigame manager and adds the world manager
func switch_to_world():
	if minigame_manager.get_parent():
		main_scene.remove_child(minigame_manager)
	main_scene.add_child(world_manager)

## Searches the minigames folder for data to use in the minigame collection
func _load_info_from_disk(path: String):
	var dir_access = DirAccess.open(path)
	for dir_name in dir_access.get_directories():
		_load_info_from_disk(path + "/" + dir_name)
	for file_name in dir_access.get_files():
		if file_name.get_extension() == "tres":
			var info_path = path + "/" + file_name
			var info : Resource = ResourceLoader.load(info_path)
			if info and info is MinigameInfo:
				print("loaded: " + info.to_string())
				minigame_collection.append(info)

func play_music(song, speed : float = 1.0, reset : bool = true):
	# song is String or AudioStream
	var resetting : bool = true
	if not reset: # user does not want to reset the song, implying that the original song should be left playing if it is a match
		if (song is String  and song == currently_playing) or (song is AudioStream and song == music_player.stream):
			resetting = false
	
	if song is String and resetting:
		if FileAccess.file_exists(song):
			music_player.stream = load(song)
			music_player.pitch_scale = speed
			currently_playing = song
			music_player.play()
	elif song is AudioStream:
		music_player.stream = song
		music_player.pitch_scale = speed
		music_player.play()

func pause_music():
	music_player.stop()
