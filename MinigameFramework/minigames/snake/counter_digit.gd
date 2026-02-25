@tool
extends Sprite2D

@export_range(0, 9, 1)
var value: int:
	get():
		return value
	set(v):
		region_rect.position.y = 10 * v
		value = v
		return v

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
