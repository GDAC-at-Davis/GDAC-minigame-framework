extends StoryEvent

var _smoke_cutscene_length = 2.0
var _story_progress: int = 1
var _smoke_scene: PackedScene = preload("res://scenes/smoke.tscn")
var _smoke: ColorRect
var _smoke_timer: Timer

var _dialogue: Array[String] = [
	"Gee: Dakki!",
	"Dakki: Gee?",
]

func on_enter():
	_story_progress = 1
	overworld.dialogue_box.dialogue_completed.connect(_on_dialogue_completed)
	_smoke = _smoke_scene.instantiate()
	_smoke.global_position = Vector2.ZERO
	_smoke_timer = Timer.new()
	_smoke_timer.timeout.connect(_on_dialogue_completed)
	_smoke_timer.autostart = false
	_smoke_timer.one_shot = true
	add_child(_smoke_timer)
	_smoke_timer.start(_smoke_cutscene_length)
	_smoke.modulate.a = 0.0
	overworld.add_to_overlay(_smoke)

func _on_dialogue_completed():
	_story_progress += 1
	if _story_progress == 2:
		overworld.dialogue_box.play_text(_dialogue)
	elif _story_progress == 3:
		_smoke_timer.start(_smoke_cutscene_length)
		_smoke.modulate.a = 1.0
	else:
		complete()

func on_update():
	if _story_progress == 1:
		_smoke.modulate.a = lerp(1.0, 0.0, _smoke_timer.time_left / _smoke_cutscene_length)
	elif _story_progress == 3:
		_smoke.modulate.a = lerp(0.0, 1.0, _smoke_timer.time_left / _smoke_cutscene_length)

func on_exit():
	overworld.dialogue_box.dialogue_completed.disconnect(_on_dialogue_completed)
	_smoke_timer.queue_free()
	_smoke.queue_free()
