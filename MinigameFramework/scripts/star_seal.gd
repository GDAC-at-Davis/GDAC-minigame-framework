class_name StarSeal
extends Node2D

var radius: float = 50.0
var star_rotation: float = 0.0

var _stars: Dictionary[Node2D, float]
var _total_star_count: int
var _star_scene: PackedScene = preload("res://scenes/star.tscn")
var _angle_between_stars: float

func _init(total_star_count: int):
	_total_star_count = total_star_count
	_angle_between_stars = TAU / total_star_count

func _physics_process(delta):
	for star: Node2D in _stars.keys():
		star.global_position = lerp(star.global_position, global_position + (Vector2.DOWN * radius).rotated(_stars[star] + star_rotation), 0.1)

func is_full() -> bool:
	return _stars.keys().size() >= _total_star_count

func add_star(initial_position: Vector2):
	if is_full():
		return
	for star: Node2D in _stars.keys():
		_stars[star] += _angle_between_stars
	var star: Node2D = _star_scene.instantiate()
	_stars[star] = 0.0
	add_child(star)
	star.global_position = initial_position
