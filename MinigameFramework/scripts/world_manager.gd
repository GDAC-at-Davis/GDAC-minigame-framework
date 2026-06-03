class_name Overworld
extends Node2D

var player: Character

var _player_scene: PackedScene = preload("res://scenes/player.tscn")

@onready var dialogue_box: DialogueBox = $UILayer/DialogueBox
@onready var world_layer = $WorldLayer
@onready var audio : AudioStreamPlayer = $Audio
@onready var story_manager: StoryManager = $StoryManager
@onready var controller: Controller = $Controller
@onready var camera: Camera2D = $Camera2D

func _ready():
	player = _player_scene.instantiate()
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

func pause_music():
	GameManager.pause_music()

func add_to_world(node: Node):
	world_layer.add_child(node)

func remove_from_world(node: Node):
	world_layer.remove_child(node)
