class_name HazardSpawner
extends Node2D

@export var hazard_scenes: Array[PackedScene]
@export var spawn_interval_start: float = 0.35
@export var spawn_interval_min: float = 0.05
@export var fall_speed_min: float = 400.0
@export var fall_speed_max: float = 1100.0

var active: bool = false
var difficulty_scale: float = 1.0

var _timer: float = 0.0
var _hazard_parent: Node
var _spawn_bounds: Vector2 = Vector2(80, 1200)
var _spawn_y: float = -40.0

func reset(hazard_parent: Node, bounds: Vector2, spawn_y: float) -> void:
	_hazard_parent = hazard_parent
	_spawn_bounds = bounds
	_spawn_y = spawn_y
	_timer = 0.0


func update_difficulty(delta: float, elapsed_time: float) -> void:
	if not active:
		return
	var t: float = clamp(elapsed_time / 60.0, 0.0, 1.0)
	var interval: float = lerpf(spawn_interval_start, spawn_interval_min, t)
	interval = max(interval / difficulty_scale, 0.05)
	_timer -= delta
	if _timer <= 0.0:
		_spawn_hazard(t)
		_timer += interval


func _spawn_hazard(difficulty_t: float) -> void:
	if hazard_scenes.is_empty():
		return
	var scene: PackedScene = hazard_scenes[randi() % hazard_scenes.size()]
	var hazard: HazardBase = scene.instantiate()
	hazard.global_position = Vector2(randf_range(_spawn_bounds.x, _spawn_bounds.y), _spawn_y)
	var fall_speed: float = lerpf(fall_speed_min, fall_speed_max, difficulty_t) * difficulty_scale
	hazard.set_fall_speed(fall_speed)
	hazard.hazard_hit_player.connect(get_parent().hazard_hit_player)
	hazard.hazard_cleared.connect(get_parent().hazard_cleared)
	_hazard_parent.add_child(hazard)
