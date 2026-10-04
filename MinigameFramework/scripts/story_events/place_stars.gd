extends StoryEvent

var star_timer_delay = 0.25

var _star_timer: Timer
var _dakki: Character

func on_enter():
	overworld.controller.possessed = null
	_star_timer = Timer.new()
	_star_timer.autostart = false
	_star_timer.one_shot = true
	_star_timer.timeout.connect(_on_star_timer_timeout)
	add_child(_star_timer)
	_star_timer.start(star_timer_delay)


func _on_star_timer_timeout():
	if overworld.star_seal.is_full():
		complete()
		return
	overworld.star_seal.add_star(overworld.dakki.global_position)
	_star_timer.start(star_timer_delay)
