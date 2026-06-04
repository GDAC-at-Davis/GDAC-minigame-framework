class_name Overworld
extends Node2D

var dakki: Character
var gee: Character

var _dakki_scene: PackedScene = preload("res://scenes/player.tscn")
var _gee_scene: PackedScene = preload("res://scenes/gee.tscn")

@onready var dialogue_box: DialogueBox = $UILayer/DialogueBox
@onready var world_layer = $WorldLayer
@onready var overlay_layer = $OverlayLayer
@onready var ui_layer = $UILayer
@onready var audio : AudioStreamPlayer = $Audio
@onready var story_manager: StoryManager = $StoryManager
@onready var controller: Controller = $WorldLayer/Controller
@onready var camera: Camera2D = $WorldLayer/Camera2D

func _ready():
	dakki = _dakki_scene.instantiate()
	gee = _gee_scene.instantiate()
	story_manager.progress_story()

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

func play_minigames(minigame_group: MinigameGroupData):
	remove_child(world_layer)
	remove_child(overlay_layer)
	remove_child(ui_layer)
	GameManager.minigame_manager.all_minigames_completed.connect(_on_minigames_completed)
	GameManager.minigame_manager.start(minigame_group)

func pause_music():
	GameManager.pause_music()

func add_to_world(node: Node):
	world_layer.add_child(node)

func remove_from_world(node: Node):
	world_layer.remove_child(node)

func add_to_overlay(node: Node):
	overlay_layer.add_child(node)

func remove_from_overlay(node: Node):
	overlay_layer.remove_child(node)

func _on_minigames_completed(won: bool):
	GameManager.minigame_manager.all_minigames_completed.disconnect(_on_minigames_completed)
	add_child(world_layer)
	add_child(overlay_layer)
	add_child(ui_layer)
