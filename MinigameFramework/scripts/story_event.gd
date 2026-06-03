class_name StoryEvent
extends Node

var overworld: Overworld

func enter():
	on_enter()

func update():
	on_update()

func exit():
	on_exit()

func complete():
	overworld.story_manager.story_event_completed()

## Called when the event is first entered.
func on_enter():
	pass

## Called every frame this event is active.
func on_update():
	pass

## Called when the event is exited.
func on_exit():
	pass
