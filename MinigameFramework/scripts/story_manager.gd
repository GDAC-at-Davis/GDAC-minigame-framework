class_name StoryManager
extends Node

var story_events: Array[StoryEvent]
var story_event_idx = -1
var overworld: Overworld

func _ready():
	overworld = get_parent()
	for event: StoryEvent in get_children():
		event.overworld = overworld
		story_events.append(event)

func _physics_process(delta):
	if story_event_idx < 0:
		return
	story_events[story_event_idx].update()

func progress_story():
	if story_events[story_event_idx]:
		story_events[story_event_idx].exit()
	story_event_idx += 1
	if story_events[story_event_idx]:
		story_events[story_event_idx].enter()

func story_event_completed():
	progress_story()
