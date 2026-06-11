class_name Character
extends CharacterBody2D

@export var animated_sprite: AnimatedSprite2D

@onready var current_scene = get_parent()

var tile_size = 32

var ANIMATIONS = {
	"right" : "RightWalk",
	"left" : "RightWalk",
	"up" : "BackWalk",
	"down" : "FrontWalk"
}

# helper functions

func move(direction: Vector2, speed: float):
	velocity = direction.normalized() * speed

func play_animation(animation_name: StringName):
	animated_sprite.play(animation_name)

func set_sprite_flipped(flipped: bool):
	animated_sprite.flip_h = flipped

# end helper functions

func _physics_process(delta):
	move_and_slide()
