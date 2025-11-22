extends CharacterBody2D

const BODY = preload("uid://ca7yc3yllp57a")

const BASE_SPEED = 1000.0
const MIN_MOVE_DIST = 16

var speed:float = BASE_SPEED

@onready var tail: CharacterBody2D = $"../Body"
var segment_closest_to_head: CharacterBody2D

func _ready() -> void:
	var scaled_pos = get_viewport().get_screen_transform() * global_position
	Input.warp_mouse(scaled_pos)
	
	$AnimatedSprite2D.play("default")
	segment_closest_to_head = tail

func _physics_process(delta: float) -> void:
	var direction:Vector2 =  get_global_mouse_position() - global_position
	
	if direction.length() > MIN_MOVE_DIST:
		var target_velocity = speed * direction / max(direction.length(), 1)
		velocity = velocity.lerp(target_velocity, delta * 10.0)
		
		var change_rotation:float = direction.angle()
		rotation = lerp_angle(rotation, change_rotation, delta * 10.0)
	else:
		velocity = Vector2.ZERO
	
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
