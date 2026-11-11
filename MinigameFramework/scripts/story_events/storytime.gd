extends StoryEvent

var _story_progress: int = 1

var _dialogue_1: Array[String] = [
	"Gee: Though as time went on, the seal began to crack.",
	"Dakki: Gee! That's all just kiddie stuff!",
	"Gee: How do you know? We're descendants of Artisans and Technologists, so we know that much is true. Why can't the rest of it be too?",
	"Dakki: A plague, sure. But a giant beast? Forcing people to make money? That's so totally made up!",
	"Gee: To me, it seems like the beast could be more and more real every day.",
	"Gee: People don't have time to make things anymore because they're too busy trying to make a living.",
	"Dakki: Sure, but—",
	"Dakki: There are still people like us who go against that. Let's just get back to making our game already.",
	"Gee: Dakki…",
	"Dakki: You can't keep putting this off.",
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
	overworld.dakki.global_position = Vector2(170.0, 45.0)
	overworld.gee.global_position = overworld.dakki.global_position + Vector2.RIGHT * 10.0
	overworld.add_to_world(overworld.gee)
	overworld.dialogue_box.dialogue_completed.connect(_on_dialogue_completed)
	overworld.dialogue_box.play_text(_dialogue_1)
	GameManager.play_music(load("res://assets/audio/storytime.mp3"))

func _on_dialogue_completed():
	_story_progress += 1
	if _story_progress == 2:
		GameManager.play_music(load("res://assets/audio/smog.wav"))
		overworld.dialogue_box.play_text(_dialogue_2)
	else:
		complete()

func on_exit():
	overworld.dialogue_box.dialogue_completed.disconnect(_on_dialogue_completed)
