extends CharacterBody2D

@export var speed : float

signal defeated

enum State {INTACT, DESTROYED}
var state

func _ready() -> void:
	state = State.INTACT
	$AnimationPlayer.play("count_down")

func detonate() -> void:
	defeated.emit()

func detonate_visuals() -> void:
	state = State.DESTROYED 
	$AnimationPlayer.play("explosion")
	velocity = Vector2.ZERO
