extends StoryEvent

var cutscene: IntroCutscene

var text: Array[String] = [
	"Hifdsaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
	"Hello",
	"Bye"
]

func on_enter():
	overworld.dialogue_box.dialogue_completed.connect(_on_dialogue_completed)
	overworld.dialogue_box.play_text(text)

func on_exit():
	overworld.dialogue_box.dialogue_completed.disconnect(_on_dialogue_completed)

func _on_dialogue_completed():
	complete()
