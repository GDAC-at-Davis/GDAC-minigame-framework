extends StoryEvent

@export var seal_radius_curve: Curve
@export var seal_rotation_speed_curve: Curve

var seal_radius_max: float =175.0
var seal_radius_min: float = 0.0

var seal_rotation_speed_min: float = 0.0
var seal_rotation_speed_max: float = PI / 32.0

var star_timer_delay = 0.1
var seal_timer_length = 5.0

var _star_seal: StarSeal
var _star_timer: Timer
var _seal_timer: Timer
var _story_progress: int = 1
var _dialogue: Array[String] = [
	"Dakki: Whoa.",
]
var _dakki: Character

func _physics_process(delta):
	if _seal_timer and _seal_timer.time_left > 0.0:
		var offset: float = inverse_lerp(5.0, 0.0, _seal_timer.time_left)
		_star_seal.radius = lerp(seal_radius_min, seal_radius_max, seal_radius_curve.sample(offset))
		_star_seal.star_rotation += lerp(seal_rotation_speed_min, seal_rotation_speed_max, seal_rotation_speed_curve.sample(offset))

func on_enter():
	overworld.dialogue_box.dialogue_completed.connect(_on_part_completed)
	overworld.dialogue_box.play_text(_dialogue)
	overworld.controller.possessed = null
	_star_seal = StarSeal.new(overworld.TOTAL_MINIGAMES)
	_star_seal.radius = lerp(seal_radius_min, seal_radius_max, seal_radius_curve.sample(0.0))
	_star_seal.global_position = Vector2(100.0, 100.0)
	overworld.add_to_world(_star_seal)
	_star_timer = Timer.new()
	_star_timer.autostart = false
	_star_timer.one_shot = true
	_star_timer.timeout.connect(_on_star_timer_timeout)
	add_child(_star_timer)
	_seal_timer = Timer.new()
	_seal_timer.autostart = false
	_seal_timer.one_shot = true
	add_child(_seal_timer)

func on_exit():
	overworld.dialogue_box.dialogue_completed.disconnect(_on_part_completed)

func _on_part_completed():
	_story_progress += 1
	if _story_progress == 2:
		_star_timer.start(star_timer_delay)
	elif _story_progress == 3:
		_seal_timer.start(seal_timer_length)

func _on_star_timer_timeout():
	if _star_seal.is_full():
		_on_part_completed()
		return
	_star_seal.add_star(overworld.dakki.global_position)
	_star_timer.start(star_timer_delay)
