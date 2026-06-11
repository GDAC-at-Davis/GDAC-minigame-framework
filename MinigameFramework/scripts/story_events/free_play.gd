extends StoryEvent

func on_enter():
	# Let the player control Dakki
	overworld.controller.possessed = overworld.dakki
