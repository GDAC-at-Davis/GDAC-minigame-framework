extends CharacterBody2D

@export var speed : float

signal defeated

enum State {INTACT, DESTROYED}
var state

func _ready() -> void:
	state = State.INTACT

func detonate() -> void:
	defeated.emit()

func detonate_visuals() -> void:
	state = State.DESTROYED 
	$ExplosionEffect.emitting = true
	$Sprite2D.visible = false
	#$DefeatTimer.start()
	velocity = Vector2.ZERO

#func _on_defeat_timer_timeout() -> void:
#	defeated.emit()
