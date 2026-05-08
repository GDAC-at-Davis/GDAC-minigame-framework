extends CharacterBody2D

@export var speed : float

signal defeated

func detonate() -> void:
	$ExplosionEffect.emitting = true
	$Sprite2D.visible = false
	$DefeatTimer.start()
	velocity = Vector2.ZERO

func _on_defeat_timer_timeout() -> void:
	defeated.emit()
