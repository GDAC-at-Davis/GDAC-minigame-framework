extends StoryEvent

func on_enter():
	var open_lab: Node = load("res://scenes/home_room.tscn").instantiate()
	overworld.add_to_world(open_lab)
	overworld.add_to_world(overworld.player)
	overworld.controller.possessed = overworld.player

func on_exit():
	pass
