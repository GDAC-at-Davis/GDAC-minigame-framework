class_name Main
extends Node

func _ready() -> void:
	GameManager.main_scene = self
	GameManager.switch_scenes(load("res://scenes/menu.tscn"))
