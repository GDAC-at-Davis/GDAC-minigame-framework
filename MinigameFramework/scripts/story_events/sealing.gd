extends StoryEvent

@export var seal_radius_curve: Curve
@export var seal_rotation_speed_curve: Curve

var seal_radius_max: float = 175.0
var seal_radius_min: float = 0.0

var seal_rotation_speed_min: float = PI / 128.0
var seal_rotation_speed_max: float = PI / 32.0

var seal_timer_length = 5.0

var overlay: ColorRect

var _seal_timer: Timer
var _story_progress: int = 1
var _dialogue_1: Array[String] = [
	"Dakki: Come face me!",
	"Dakki: I know you're here.",
	"Dakki: I've learned a lot y'know. You should be afraid now.",
	"Dakki: I was right from the start.",
	"Dakki: These stars are proof. Come out so I can say that I told you so!",
]

var _dialogue_2: Array[String] = [
	"Monster: Stars? That's all you've got?",
	"Dakki: They mean a lot to me. They mean a lot to Gee too.",
	"Dakki: Release her. We're finishing that game.",
	"Dakki: Those cornerstones,",
	"Dakki: You said that they were weakened because people had forgotten them.",
	"Dakki: But that's not true at all!",
	"Dakki: If they were forgotten, then why are they still here?",
	"Monster: You foolish girl! Just because things exist, it doesn't mean that they actually mean anything!",
	"Monster: You think that those playthings actually matter at all?",
	"Dakki: You couldn't be more wrong.",
	"Dakki: The fact that they exist is meaning enough.",
	"Dakki: Each one, just by existing, is proof of passion.",
	"Dakki: Those games saved people.",
	"Dakki: They brought people together and patched societies together.",
	"Dakki: Money? Profit? That wasn't even a concern back then!",
	"Dakki: Art should be made just to be made.",
	"Dakki: And in turn, they'll have their own effect.",
	"Dakki: That's what I've learned from these cornerstones.",
	"Dakki: And I'm gonna make my own.",
	"Dakki: But I'm not doing it without Gee!",
	"Monster: HAHAHAHAHAHAHAHAHA",
	"Monster: YOU REALLY ARE A FOOL!",
	"Monster: NOTHING IN THIS WORLD MATTERS MORE THAN PROFIT.",
	"Monster: TIMES HAVE CHANGED, LITTLE GIRL.",
	"Monster: IT'S TIME THAT YOU DO TOO.",
	"Dakki: NO!",
	"Dakki: Why don't you get it!",
	"Dakki: Art will never need to be about profit.",
	"Dakki: If we take that turn…",
	"Dakki: Everything will be worse.",
]

var _dakki: Character
var _monster: Character

func _physics_process(delta):
	if _seal_timer:
		var offset: float
		if _story_progress >= 4 or not _seal_timer.is_stopped():
			offset = inverse_lerp(5.0, 0.0, _seal_timer.time_left)
		else:
			offset = 0.0
		overworld.star_seal.radius = lerp(seal_radius_min, seal_radius_max, seal_radius_curve.sample(offset))
		overworld.star_seal.star_rotation += lerp(seal_rotation_speed_min, seal_rotation_speed_max, seal_rotation_speed_curve.sample(offset))

func on_enter():
	overworld.dialogue_box.dialogue_completed.connect(_on_part_completed)
	overworld.dialogue_box.play_text(_dialogue_1)
	overworld.controller.possessed = null
	_seal_timer = Timer.new()
	_seal_timer.autostart = false
	_seal_timer.one_shot = true
	add_child(_seal_timer)
	_seal_timer.timeout.connect(_on_seal_timer_timeout)

func on_exit():
	overworld.dialogue_box.dialogue_completed.disconnect(_on_part_completed)

func _on_part_completed():
	_story_progress += 1
	if _story_progress == 2:
		_monster = load("res://scenes/monster.tscn").instantiate()
		overworld.add_to_world(_monster)
		_monster.modulate = Color.TRANSPARENT
		_monster.global_position = overworld.dakki.global_position + Vector2.UP * 15.0
		var appear_tween: Tween = create_tween()
		appear_tween.tween_property(_monster, "modulate", Color(1, 1, 1, 1), 1.0)
		appear_tween.tween_callback(_on_part_completed)
	if _story_progress == 3:
		overworld.dakki.play_animation(&"BackIdle")
		overworld.dialogue_box.play_text(_dialogue_2)
	if _story_progress == 4:
		_seal_timer.start(seal_timer_length)
	if _story_progress == 5:
		complete()

func _on_seal_timer_timeout():
	overlay = ColorRect.new()
	overlay.size = Vector2(1280, 720)
	overlay.color = Color(1, 1, 1, 0)
	overlay.global_position = Vector2.ZERO
	overworld.add_to_overlay(overlay)
	var overlay_tween: Tween = create_tween()
	overlay_tween.tween_property(overlay, "color", Color(1, 1, 1, 1), 1.0)
	overlay_tween.tween_callback(_on_part_completed)
	
