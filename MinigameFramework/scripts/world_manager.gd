class_name WorldManager
extends Node2D

signal story_state_completed

enum StoryState {
	STORY_INTRO,
	OPEN_LAB_INTRO,
	MINIGAMES,
	SMOKE_BEAST,
	FINAL_BATTLE,
}

var active_scene: Node = null:
	get():
		return active_scene
var active_ui = null:
	get():
		return active_ui

var current_story_state: StoryState = StoryState.STORY_INTRO

@onready var ui_layer = $UILayer
@onready var world_layer = $WorldLayer
@onready var audio : AudioStreamPlayer = $Audio

func progress_story():
	match current_story_state:
		StoryState.STORY_INTRO:
			load_ui("res://scenes/cutscene.tscn")
			await story_state_completed
			delete_ui()
			load_world("res://scenes/home_room.tscn")
			

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

#func play_music(song, speed : float = 1.0):
	#if song in music_dict.keys():
			#GameManager.play_music(music_dict[song], speed)
	# Do this later

func pause_music():
	GameManager.pause_music()

func load_world(scene_path : String):
	if active_scene != null:
		active_scene.queue_free()
		active_scene = null
	var new_scene = load(scene_path)
	if new_scene:
		active_scene = new_scene.instantiate()
		world_layer.add_child(active_scene)

func delete_world():
	if active_scene != null:
		active_scene.queue_free()

func load_ui(ui_path : String):
	if active_ui != null:
		active_ui.queue_free()
		active_ui = null
	var new_scene = load(ui_path)
	if new_scene:
		active_ui = new_scene.instantiate()
		ui_layer.add_child(active_ui)

func delete_ui():
	if active_ui != null:
		active_ui.queue_free()
