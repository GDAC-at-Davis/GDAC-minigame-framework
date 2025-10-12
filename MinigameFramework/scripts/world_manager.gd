class_name WorldManager
extends Node2D

const scene_dict = {
	"Home" : preload("res://scenes/home_room.tscn"),
}

const ui_dict = {
	"Menu" : preload("res://scenes/menu.tscn"),
	"Collection" : preload("res://scenes/minigame_collection.tscn"),
	"Home" : preload("res://scenes/ui.tscn"),
}

var active_scene = null:
	get():
		return active_scene
var active_ui = null:
	get():
		return active_ui

@onready var ui_canvas = $UICanvas

# Helper functions

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
