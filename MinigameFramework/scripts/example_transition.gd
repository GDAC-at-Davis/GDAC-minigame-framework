extends Node2D

@onready var funny_little_guy: AnimationPlayer = $AnimatedSprite2D/AnimationPlayer

func _ready() -> void:
	funny_little_guy.play(&"spin") 
