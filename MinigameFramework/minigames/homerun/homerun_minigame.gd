extends Minigame

const BASE_SPEED := 250

@export var pitcher: Node2D


var ball_scene: PackedScene = preload("res://minigames/homerun/ball.tscn")
var ball: Area2D

var speed: float
var has_pitched = false
var has_hit = false

@onready var swing_hitbox: Area2D = $Player/SwingArea


## This is called once at the start of the minigame.
func start() -> void:
	print("starting homerun")
	speed = BASE_SPEED * difficulty
	pitch()


## This is called 60 times per second.
func _physics_process(_delta):
	super(_delta)
	
	if has_pitched:
		if has_hit:
			ball.position.y -= speed * _delta
		else:
			ball.position.y += speed * _delta


func run():
	if Input.is_action_just_pressed("primary"):
		if is_valid_hit():
			print("hit!")
			has_hit = true
			has_won = true
		else:
			print("miss!")


## This is called after win() or lose() is called.
func end() -> void:
	pass


func pitch() -> void:
	ball = ball_scene.instantiate()
	add_child(ball)
	ball.global_position = pitcher.global_position
	has_pitched = true


func is_valid_hit() -> bool:
	var areas = ball.get_overlapping_areas()
	
	for area in areas:
		if area.name == "SwingArea":
			return true
	return false
