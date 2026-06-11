extends StoryEvent

var _dialogue: Array[String] = [
	"Dakki: Gee? Gee, where are you?",
]

func on_enter():
	overworld.dialogue_box.dialogue_completed.connect(_on_dialogue_completed)
	overworld.dialogue_box.play_text(_dialogue)

func on_exit():
	overworld.dialogue_box.dialogue_completed.disconnect(_on_dialogue_completed)

func _on_dialogue_completed():
	complete()
