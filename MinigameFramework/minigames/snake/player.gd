extends CharacterBody2D

const BODY = preload("uid://ca7yc3yllp57a")

const BASE_SPEED = 1000.0

var speed:float = BASE_SPEED

@onready var tail: CharacterBody2D = $"../Body"

func _ready() -> void:
	$AnimatedSprite2D.play("default")

func _physics_process(delta: float) -> void:
	var direction := Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	
	velocity = speed * direction / max(direction.length(), 1)
	
	if velocity.length() > 0:
		var change_rotation = velocity.angle()
		rotation = lerp_angle(rotation, change_rotation, delta * 10.0)
	
	move_and_slide()


func _on_snake_pickup_gotten(current_count: int) -> void:
	elongate()


func elongate() -> void:
	tail.sprite.texture = preload("res://minigames/snake/sprite_texture/snake_body.png")
	var new_tail: SnakeMinigameBody = BODY.instantiate()
	get_parent().add_child(new_tail)
	new_tail.previous_segment = tail
	new_tail.global_position = tail.global_position
	tail = new_tail
