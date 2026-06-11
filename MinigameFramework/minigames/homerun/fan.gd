class_name Fan
extends Node2D

const GRAVITY: float = 1800
const BASE_JUMP_SPEED: float = 400
const JUMP_DELAY_RANGE: float = 0.2

var speed: float = 0
var is_jumping: bool = false
var original_pos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	original_pos = self.global_position
	randomize_color()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.global_position.y -= speed * delta
	
	speed -= GRAVITY * delta
	
	if self.global_position.y > original_pos.y:
		
		self.global_position.y = original_pos.y
	
		if is_jumping:
			speed = BASE_JUMP_SPEED


func start_jumping() -> void:
	var jump_timer = Timer.new()
	add_child(jump_timer)
	
	jump_timer.wait_time = randf_range(0, JUMP_DELAY_RANGE)
	jump_timer.one_shot = true 
	jump_timer.timeout.connect(_start_jumping)
	jump_timer.start()


func _start_jumping() -> void:
	speed = BASE_JUMP_SPEED
	is_jumping = true


func randomize_color() -> void:
	var sprite = $body
	
	var r = randf()
	var g = randf()
	var b = randf()
	sprite.modulate = Color(r, g, b, 1.0)
