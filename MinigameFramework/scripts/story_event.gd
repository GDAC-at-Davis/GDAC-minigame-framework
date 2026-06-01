class_name StoryEvent
extends Node

var overworld: Overworld

func enter():
	on_enter()

func update():
	on_update()

func complete():
	on_complete()

## Called when the event is first entered.
func on_enter():
	pass

## Called every frame this event is active.
func on_update():
	pass

## Called when the event is completed.
func on_complete():
	pass

## Condition for whether the event has been completed. This is checked every frame.
func is_event_completed():
	return false
