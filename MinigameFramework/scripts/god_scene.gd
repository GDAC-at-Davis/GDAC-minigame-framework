class_name GodScene
extends Node2D

const scene_dict = {
	"Home" : preload("res://scenes/HomeRoom.tscn"),
}

const ui_dict = {
	"Menu" : preload("res://scenes/Menu.tscn"),
	"Home" : preload("res://scenes/UI.tscn"),
}

var minigame_manager_scene: PackedScene = preload("res://scenes/MinigameManager.tscn")
var active_scene = null
var active_ui = null

@onready var ui_canvas = $UICanvas

# Helper functions

func load_scene(scene_name : String):
	if active_scene != null:
		active_scene.queue_free()
		active_scene = null
	if active_ui != null:
		active_ui.queue_free()
		active_ui = null
	if scene_name in ui_dict:
		active_ui = ui_dict[scene_name].instantiate()
		ui_canvas.add_child(active_ui)
	if scene_name in scene_dict:
		active_scene = scene_dict[scene_name].instantiate()
		add_child(active_scene)

func load_minigame_manager(data: MinigameGroupData):
	if active_scene != null:
		active_scene.queue_free()
		active_scene = null
	if active_ui != null:
		active_ui.queue_free()
		active_ui = null
	active_scene = minigame_manager_scene.instantiate()
	(active_scene as MinigameManager).setup_data(data)
	add_child(active_scene)

func get_ui():
	return active_ui

# End of helper functions

func _ready() -> void:
	load_scene("Menu")
