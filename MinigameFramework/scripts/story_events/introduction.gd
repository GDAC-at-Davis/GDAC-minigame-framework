extends StoryEvent

var cutscene: IntroCutscene

var text: Array[String] = [
	"Hifdsaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
	"Hello",
	"Bye"
]

func on_enter():
	overworld.dialogue_box.play_text(text)

func on_complete():
	overworld.delete_ui()

func is_event_completed():
	if cutscene:
		return cutscene.complete
	else:
		return false
