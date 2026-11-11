extends StoryEvent

var _dialogue: Array[String] = [
	"Dakki: Gee? Gee, where are you?",
	"Your cornerstones have lost their effect.",
	"Forgotten because of their lack of revenue.",
	"Useless.",
	"These playthings are useless.",
	"Dakki: Who are you!",
	"Games forgotten.",
	"Things not worth playing.",
	"What's the point?",
	"Dakki: There's always a point.",
	"Your friend is gone.",
	"Wandering one of these worlds.",
	"It's what happens when you waste all your time on such frivolous matters.",
	"Go, find her. But you'll only meet the same fate."
]

func on_enter():
	overworld.dialogue_box.dialogue_completed.connect(_on_dialogue_completed)
	overworld.dialogue_box.play_text(_dialogue)
	GameManager.play_music(load("res://assets/audio/room_of_stars.mp3"))

func on_exit():
	overworld.dialogue_box.dialogue_completed.disconnect(_on_dialogue_completed)

func _on_dialogue_completed():
	complete()
