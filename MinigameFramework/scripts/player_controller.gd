class_name Controller
extends Node

@export var movement_speed: float = 50.0

var possessed: Character

func _physics_process(delta):
	if possessed:
		possessed.move(Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")), movement_speed)
		if possessed.velocity.y > 0.0:
			possessed.play_animation(&"FrontWalk")
		elif possessed.velocity.y < 0.0:
			possessed.play_animation(&"BackWalk")
		elif possessed.velocity.x < 0.0:
			possessed.set_sprite_flipped(true)
			possessed.play_animation(&"RightWalk")
		elif possessed.velocity.x > 0.0:
			possessed.set_sprite_flipped(false)
			possessed.play_animation(&"RightWalk")
