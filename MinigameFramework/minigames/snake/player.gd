extends CharacterBody2D

const BODY = preload("uid://ca7yc3yllp57a")

const BASE_SPEED = 700.0

var speed:float = BASE_SPEED

@onready var tail: CharacterBody2D = $"../Body"


func _physics_process(delta: float) -> void:
	var direction := Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	
	velocity = speed * direction / max(direction.length(), 1)
	
	if velocity.length() > 0:
		var change_rotation = velocity.angle()
		$Icon.rotation = lerp_angle($Icon.rotation, change_rotation, delta * 10.0)
	
	move_and_slide()


func _on_snake_pickup_gotten(current_count: int) -> void:
	elongate()


func elongate() -> void:
	var new_tail: SnakeMinigameBody = BODY.instantiate()
	get_parent().add_child(new_tail)
	new_tail.previous_segment = tail
	new_tail.global_position = tail.global_position
	tail = new_tail
