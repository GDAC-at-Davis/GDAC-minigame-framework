class_name StoryManager
extends Node

var story_events: Array[StoryEvent]
var story_event_idx = -1

func _ready():
	for event: StoryEvent in get_children():
		story_events.append(event)

func _physics_process(delta):
	if story_event_idx < 0:
		return
	if story_events[story_event_idx].is_event_completed():
		progress_story()
	story_events[story_event_idx].update()

func progress_story():
	if story_events[story_event_idx]:
		story_events[story_event_idx].complete()
	story_event_idx += 1
	if story_events[story_event_idx]:
		story_events[story_event_idx].enter()
