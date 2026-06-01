class_name Overworld
extends Node2D

var active_scene: Node = null:
	get():
		return active_scene
var active_ui: Node = null:
	get():
		return active_ui



@onready var dialogue_box: DialogueBox = $UILayer/DialogueBox
@onready var world_layer = $WorldLayer
@onready var audio : AudioStreamPlayer = $Audio
@onready var story_manager: StoryManager = $StoryManager

func _ready():
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

func load_world(scene_path : String) -> Node:
	if active_scene != null:
		active_scene.queue_free()
		active_scene = null
	var new_scene = load(scene_path)
	if new_scene:
		active_scene = new_scene.instantiate()
		world_layer.add_child(active_scene)
		return active_scene
	else:
		return null

func delete_world():
	if active_scene != null:
		active_scene.queue_free()

func delete_ui():
	if active_ui != null:
		active_ui.queue_free()
