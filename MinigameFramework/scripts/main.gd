class_name Main
extends Node

@onready var minigame_manager = $MinigameManager

func _ready() -> void:
	GameManager.main_scene = self
	GameManager.minigame_manager = minigame_manager
	GameManager.switch_scenes(load("res://scenes/menu.tscn"))
