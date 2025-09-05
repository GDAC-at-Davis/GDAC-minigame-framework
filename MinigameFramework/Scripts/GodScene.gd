extends Node2D

const scene_dict = {
	"Home" : preload("res://Scenes/HomeRoom.tscn")
}

const ui_dict = {
	"Menu" : preload("res://Scenes/Menu.tscn"),
	"Home" : preload("res://Scenes/UI.tscn")
}

@onready var ui_canvas = $UICanvas

var active_scene = null
var active_ui = null

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
		
func get_ui():
	return active_ui

# End of helper functions

func _ready() -> void:
	load_scene("Menu")
