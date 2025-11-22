extends Minigame

@onready var ball:CharacterBody2D = %Soccerball
@onready var goalie:CharacterBody2D = %Goalie
@onready var arrow:Sprite2D = %Arrow
@onready var goal:StaticBody2D = %Goal

func _process(_delta):
	if ball.shot == false:
		if Input.is_action_just_pressed("primary") and arrow.turning:
				arrow.turning = false
				arrow.growing = true
		if Input.is_action_just_pressed("primary") and arrow.growing:
				arrow.growing = false
				var ball_direction = Vector2.from_angle(arrow.rotation).normalized()
				ball.velocity = ball_direction*ball.speed*arrow.scale.x
				ball.shot = true

func start():
	ball.position = Vector2(640,630)
	ball.velocity = Vector2(0,0)
	
	goalie.position = Vector2(640,180)
	
	arrow.turning = true
	arrow.growing = false
	arrow.scale = Vector2(0.15,0.15)
	arrow.rotation_degrees = -90
	
