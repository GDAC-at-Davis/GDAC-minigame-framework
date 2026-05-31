extends StoryEvent

var cutscene: IntroCutscene

func on_enter():
	cutscene = GameManager.world_manager.load_ui("res://scenes/cutscene.tscn")

func on_complete():
	GameManager.world_manager.delete_ui()

func is_event_completed():
	if cutscene:
		return cutscene.complete
	else:
		return false
