extends Minigame

@onready var line = $Bar/Line
@onready var target_area = $Bar/Zone
@onready var background = $Bar
@onready var lose_sound = $lose
@onready var win_sound = $win

var speed: float = 0
var direction: int = Direction.RIGHT

enum Direction {
	LEFT = -1,
	RIGHT = 1,
}

func start():
	# where it will start
	line.position.x = 0
	# speed of line
	speed = 550 * difficulty
	
	target_area.position.x = randf_range(0, background.size.x)

func run():
	var speed_with_direction = speed * direction
	line.position.x += get_physics_process_delta_time() * speed_with_direction
	
	if line.position.x <= 0:
		direction = Direction.RIGHT
	elif line.position.x >= (background.size.x - line.size.x):
		direction = Direction.LEFT
	
	var target_zone_start = target_area.position.x
	var target_zone_end = target_zone_start + target_area.size.x
	
	if Input.is_action_just_pressed("primary"):
		var pressed_location = line.position.x
		
		if pressed_location < target_zone_end and pressed_location > target_zone_start:
			win()
		else:
			lose()
	
func win():
	super()
	win_sound.play()

func lose():
	super()
	lose_sound.play()
