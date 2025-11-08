extends CharacterBody2D

const BODY = preload("uid://ca7yc3yllp57a")

const SPEED = 500.0
const JUMP_VELOCITY = -400.0


@onready var tail: CharacterBody2D = $"../Body"


func _physics_process(delta: float) -> void:
	var direction := Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	
	velocity = SPEED * direction / max(direction.length(), 1)
	
	if Input.is_action_just_pressed("ui_accept"):
		var new_tail: SnakeMinigameBody = BODY.instantiate()
		get_parent().add_child(new_tail)
		new_tail.previous_segment = tail
		new_tail.global_position = tail.global_position
		tail = new_tail
		
	move_and_slide()
