extends StoryEvent

func on_enter():
	GameManager.world_manager.load_world("res://scenes/home_room.tscn")

func on_complete():
	pass

func is_event_completed():
	return false
