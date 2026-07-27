extends StoryEvent

var _story_progress: int = 1
var _dialogue: Array[String] = [
	"Dakki: Whoa.",
]

func on_enter():
	overworld.dialogue_box.dialogue_completed.connect(_on_part_completed)
	overworld.dialogue_box.play_text(_dialogue)
	overworld.controller.possessed = null

func on_exit():
	overworld.dialogue_box.dialogue_completed.disconnect(_on_part_completed)

func _on_part_completed():
	_story_progress += 1
	if _story_progress == 2:
		pass
