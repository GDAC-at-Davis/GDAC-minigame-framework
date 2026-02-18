class_name WorldManager
extends Node2D

@export var scene_dict : Dictionary[String, PackedScene] = {
	"Home" : preload("res://scenes/home_room.tscn"),
	"Empty" : preload("res://scenes/empty.tscn")
}

@export var ui_dict = {
	"Menu" : preload("res://scenes/menu.tscn"),
	"Collection" : preload("res://scenes/minigame_collection.tscn"),
	"Home" : preload("res://scenes/ui.tscn"),
	"Cutscene" : preload("res://scenes/cutscene.tscn")
}

@export var music_dict : Dictionary[String, AudioStream]= {
	"Cutscene" : preload("res://assets/audio/cutscene_audio.wav")
}

var active_scene = null:
	get():
		return active_scene
var active_ui = null:
	get():
		return active_ui

@onready var ui_canvas = $UICanvas
@onready var audio : AudioStreamPlayer = $Audio

# Helper functions

func has_node_of_type(parent: Node, type):
	for child in parent.get_children():
		if is_instance_of(child, type):
			return true
	return false
	
func get_node_of_type(parent: Node, type):
	for child in parent.get_children():
		if is_instance_of(child, type):
			return child
	return null

func load_level(level_name : String, delete : bool = true, keep_running : bool = false):
	if level_name in scene_dict.keys():
		load_scene(level_name, delete, keep_running)
	else:
		load_scene("Empty", delete, keep_running)
	if level_name in ui_dict.keys():
		load_ui(level_name, delete, keep_running)

func play_music(song : String, speed : float = 1.0):
	if song in music_dict.keys():
		audio.stream = music_dict[song]
		audio.pitch_scale = speed
		audio.play()

func pause_music():
	audio.stop()

func load_scene(scene_name : String, delete : bool = true, keep_running : bool = false):
	if active_scene != null:
		if delete:
			active_scene.queue_free()
		elif keep_running:
			active_scene.visible = false
		else:
			remove_child(active_scene)
		active_scene = null
	var new_scene = scene_dict.get(scene_name)
	if new_scene:
		active_scene = new_scene.instantiate()
		add_child(active_scene)

func load_ui(ui_name : String, delete : bool = true, keep_running : bool = false):
	if active_ui != null:
		if delete:
			active_ui.queue_free()
		elif keep_running:
			active_ui.visible = false
		else:
			ui_canvas.remove_child(active_ui)
		active_ui = null
	var new_ui = ui_dict.get(ui_name)
	if new_ui:
		active_ui = new_ui.instantiate()
		ui_canvas.add_child(active_ui)

# End of helper functions

func _ready() -> void:
	load_scene("Menu")
