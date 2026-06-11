class_name HazardBase
extends Area2D

signal hazard_hit_player

@export var base_fall_speed: float = 250.0
@export var fall_speed_variance: float = 50.0
@export var offscreen_y: float = 800.0

var _fall_speed: float = -1.0
var _active: bool = true

func set_fall_speed(speed: float) -> void:
	# Add some randomness so hazards are not uniform.
	_fall_speed = speed + randf_range(-fall_speed_variance, fall_speed_variance)


func freeze_motion() -> void:
	_active = false


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	if _fall_speed < 0.0:
		_fall_speed = base_fall_speed


func _physics_process(delta: float) -> void:
	if not _active:
		return
	global_position.y += _fall_speed * delta
	if global_position.y > offscreen_y:
		_active = false
		queue_free()


func _on_body_entered(body: Node) -> void:
	if not _active:
		return
	if body is CharacterBody2D:
		_active = false
		hazard_hit_player.emit()
		queue_free()
