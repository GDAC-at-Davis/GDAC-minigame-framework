@abstract
class_name Interactable
extends Area2D

@export var sprite_node: Sprite2D

var _highlight_material: ShaderMaterial = preload("res://resources/materials/interactable_highlight.tres")
var _highlight_frame: int = 0

@abstract
func interact(player: Character)

func _physics_process(delta):
	if _highlight_frame == 0:
		if sprite_node:
			sprite_node.material = null
	else:
		_highlight_frame -= 1

func set_highlight(is_highlighted: bool):
	if not sprite_node:
		return
	if is_highlighted:
		_highlight_frame = 2
		sprite_node.material = _highlight_material
	else:
		_highlight_frame = 0
