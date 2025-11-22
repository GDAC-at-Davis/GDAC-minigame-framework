extends Minigame

@onready var ball:CharacterBody2D = %Soccerball
@onready var goalie:StaticBody2D = %Goalie
@onready var arrow:Sprite2D = %Arrow

var goal_made:bool = false

func _process(_delta) -> void:
	if ball.shot == false:
		if Input.is_action_pressed("primary") and arrow.turning:
				arrow.turning = false
				arrow.growing = true
				pass
				
		if Input.is_action_pressed("secondary") and arrow.growing:
				arrow.growing = false
				var ball_direction = Vector2.from_angle(arrow.rotation).normalized()
				ball.velocity = ball_direction*ball.SPEED*(arrow.scale.length() - 0.05)*20
				ball.shot = true
				
	if (ball.position.x > (355 + 100*(1-difficulty)) 
			and ball.position.x < (925 - 100*(1-difficulty))
			and ball.position.y < 125 and ball.position.x > 30):
		win()

func start() -> void:
	goal_made = false
	
	ball.position = Vector2(640,630)
	ball.velocity = Vector2(0,0)
	
	goalie.position = Vector2(640,180)
	
	arrow.turning = true
	arrow.growing = false
	arrow.scale = Vector2(0.15,0.15)
	arrow.rotation_degrees = -90
	
