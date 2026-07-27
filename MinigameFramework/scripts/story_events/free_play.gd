extends StoryEvent

func on_enter():
	# Let the player control Dakki
	overworld.controller.possessed = overworld.dakki
	overworld.minigame_completed.connect(on_minigame_completed)

func on_exit():
	overworld.minigame_completed.disconnect(on_minigame_completed)

func on_minigame_completed():
	if overworld.get_completed_minigame_count() >= overworld.TOTAL_MINIGAMES:
		complete()
