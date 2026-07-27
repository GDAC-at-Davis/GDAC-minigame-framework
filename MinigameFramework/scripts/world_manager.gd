class_name Overworld
extends Node2D

signal overworld_loading_completed

var dakki: Character
var gee: Character

var _completed_minigames: Array[StringName]

var _dakki_scene: PackedScene = preload("res://scenes/player.tscn")
var _gee_scene: PackedScene = preload("res://scenes/gee.tscn")
var _base_minigame_data: MinigameGroupData = preload("res://resources/minigame_groups/overworld_minigame_group.tres")


@onready var dialogue_box: DialogueBox = $UILayer/DialogueBox
@onready var world_layer = $WorldLayer
@onready var overlay_layer = $OverlayLayer
@onready var ui_layer = $UILayer
@onready var sound_player : AudioStreamPlayer = $SoundPlayer
@onready var story_manager: StoryManager = $StoryManager
@onready var controller: Controller = $WorldLayer/Controller
@onready var camera: Camera2D = $WorldLayer/Camera2D
@onready var fullscreen_image: TextureRect = $UILayer/FullscreenImage

func _ready():
	dakki = _dakki_scene.instantiate()
	gee = _gee_scene.instantiate()
	story_manager.progress_story()

func play_minigames(minigame_group: MinigameGroupData):
	remove_child(world_layer)
	remove_child(overlay_layer)
	remove_child(ui_layer)
	GameManager.minigame_manager.all_minigames_completed.connect(_on_minigames_completed)
	GameManager.minigame_manager.start(minigame_group)

func add_to_world(node: Node):
	world_layer.add_child(node)

func remove_from_world(node: Node):
	world_layer.remove_child(node)

func add_to_overlay(node: Node):
	overlay_layer.add_child(node)

func remove_from_overlay(node: Node):
	overlay_layer.remove_child(node)

func get_completed_minigame_count() -> int:
	return _completed_minigames.size()

func add_completed_minigame(minigame_id: StringName):
	if not _completed_minigames.has(minigame_id):
		_completed_minigames.append(minigame_id)

func _on_minigames_completed(won: bool):
	GameManager.minigame_manager.all_minigames_completed.disconnect(_on_minigames_completed)
	add_child(world_layer)
	add_child(overlay_layer)
	add_child(ui_layer)
	overworld_loading_completed.emit()
