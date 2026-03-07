extends CharacterBody2D

const BODY = preload("uid://ca7yc3yllp57a")

const BASE_SPEED = 1000.0
const MIN_MOVE_DIST = 16

var speed:float = BASE_SPEED

@onready var sprite = $AnimatedSprite2D
@onready var tail: CharacterBody2D = $"../Body"
var segment_closest_to_head: CharacterBody2D

const JUMP_SPEED = 700.0
var jump_delay: float = 0.9
var is_jumping: bool = false
var original_sprite_y: float = 0.0
var stuck_timer: float = 0.0
var is_stuck: bool = false

func _ready() -> void:
	var scaled_pos = get_viewport().get_screen_transform() * global_position
	Input.warp_mouse(scaled_pos)
	
	sprite.play("default")
	segment_closest_to_head = tail
	original_sprite_y = sprite.position.y
	z_index = 200
	tail.z_index = 199

func _physics_process(delta: float) -> void:
	if is_jumping:
		move_and_slide()
		var scaled_pos = get_viewport().get_screen_transform() * global_position
		Input.warp_mouse(scaled_pos)
		return
	
	var direction:Vector2 =  get_global_mouse_position() - global_position
	
	if direction.length() > MIN_MOVE_DIST:
		var target_velocity = speed * direction / max(direction.length(), 1)
		velocity = velocity.lerp(target_velocity, delta * 10.0)
		
		var change_rotation:float = direction.angle()
		rotation = lerp_angle(rotation, change_rotation, delta * 10.0)

	else:
		velocity = Vector2.ZERO
	move_and_slide()
	
	is_stuck = false
	for i in get_slide_collision_count():
		var colision = get_slide_collision(i)
		var colider =  colision.get_collider()
		if colider is SnakeMinigameBody:
			is_stuck = true
			break
	if is_stuck:
		stuck_timer += delta
		if stuck_timer >= jump_delay:
			stuck_timer = 0.0
			do_snake_jump()
	else:
		stuck_timer = 0.0

func _on_snake_pickup_gotten(current_count: int) -> void:
	elongate()


func elongate() -> void:
	tail.sprite.texture = preload("res://minigames/snake/sprite_texture/snake_body.png")
	var new_tail: SnakeMinigameBody = BODY.instantiate()
	get_parent().add_child(new_tail)
	new_tail.z_index = tail.z_index - 1
	new_tail.previous_segment = tail
	var direction = tail.global_position - tail.previous_segment.global_position
	new_tail.global_position = tail.global_position + direction
	new_tail.rotation = (tail.previous_segment.global_position - tail.global_position).angle()
	tail = new_tail

func do_snake_jump() -> void:
	is_jumping = true
	set_collision_mask_value(1, false)
	var forward_direction = Vector2.RIGHT.rotated(rotation)
	velocity = forward_direction * JUMP_SPEED
	var tween = create_tween()
	tween.tween_property(sprite, "position:y", original_sprite_y -30, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(sprite, "position:y", original_sprite_y, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	await tween.finished
	set_collision_mask_value(1, true)
	is_jumping = false
