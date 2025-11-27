extends Minigame

var ball_scene: PackedScene = preload("res://minigames/homerun/ball.tscn")
var ball: Area2D

var has_pitched = false
var has_hit = false


@export var pitcher: Node2D


## This is called once at the start of the minigame.
func start() -> void:
	print("starting homerun")
	pitch()


## This is called 60 times per second.
func _physics_process(_delta):
	super(_delta)
	
	if has_pitched:
		if has_hit:
			ball.position.y -= 100
		else:
			ball.position.y += 100


func run():
	if Input.is_action_just_pressed("primary"):
		win()


## This is called after win() or lose() is called.
func end() -> void:
	pass


func pitch() -> void:
	ball = ball_scene.instantiate()
	add_child(ball)
	ball.global_position = pitcher.global_position
	has_pitched = true
