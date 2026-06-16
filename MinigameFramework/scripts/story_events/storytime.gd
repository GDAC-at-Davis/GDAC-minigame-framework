extends StoryEvent

var _story_progress: int = 1

var _dialogue_1: Array[String] = [
	"Gee: Though as time went on, the seal began to crack.",
	"Dakki: Gee! That's all just kiddie stuff!",
]

var _dialogue_2: Array[String] = [
	"Gee: No, Dakki... what is that?",
]

func on_enter():
	_story_progress = 1
	# Create the open lab along with the characters
	var open_lab: Node = load("res://scenes/home_room.tscn").instantiate()
	overworld.add_to_world(open_lab)
	overworld.add_to_world(overworld.dakki)
	overworld.dakki.global_position = overworld.dakki.global_position + Vector2.RIGHT * 10.0
	overworld.gee.global_position = overworld.dakki.global_position + Vector2.RIGHT * 50.0
	overworld.add_to_world(overworld.gee)
	overworld.dialogue_box.dialogue_completed.connect(_on_dialogue_completed)
	overworld.dialogue_box.play_text(_dialogue_1)

func _on_dialogue_completed():
	_story_progress += 1
	if _story_progress == 2:
		overworld.dialogue_box.play_text(_dialogue_2)
	else:
		complete()

func on_exit():
	overworld.dialogue_box.dialogue_completed.disconnect(_on_dialogue_completed)
