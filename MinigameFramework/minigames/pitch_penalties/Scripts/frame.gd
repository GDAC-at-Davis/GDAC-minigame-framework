extends Node2D

@export var left:StaticBody2D
@export var top:StaticBody2D
@export var right:StaticBody2D


func _process(_delta: float) -> void:
	var difficulty:float = GameManager.minigame_manager.difficulty_scale
	left.position.x = -100*(1-difficulty)
	top.scale.x = (570 + (100*(1-difficulty)*2)) / 570
	right.position.x = 100*(1-difficulty)
	
