class_name DialogueBox
extends Control

@onready var scene = get_parent()
@onready var text = $TextPanel/Text
@onready var panel = $TextPanel

@export var text_speed : float = 1.0
var speed_threshold : float = 0.05
var playing : bool = false # is text scrolling
var speed_tracker : float = 0.0
var current_text : Array = []
var current_text_counter : int = 0
var ready_to_advance : bool = false
var next_scene : MinigameGroupData = null

func play_text(playtext : Array, optional_next_scene : MinigameGroupData = null):
	panel.visible = true
	next_scene = optional_next_scene
	current_text = playtext
	text.text = playtext[0]
	current_text_counter = 0
	text.visible_characters = 0
	playing = true
	ready_to_advance = false
	
func play_text_index(index : int):
	if index >= len(current_text):
		return
	text.text = current_text[index]
	current_text_counter = index
	text.visible_characters = 0
	playing = true
	
func _input(event):
	if playing and ready_to_advance and event.is_action_pressed("primary"):
			ready_to_advance = false
			
			if current_text_counter < len(current_text) - 1:
				play_text_index(current_text_counter + 1)
			else:
				playing = false
				panel.visible = false
				if next_scene != null:
					GameManager.switch_to_minigames(next_scene)
				
	if playing and not ready_to_advance and event.is_action_pressed("primary"):
		text.visible_characters = len(text.text)

	
func _process(delta: float) -> void:
	if playing and not ready_to_advance:
		if text.visible_characters < len(text.text):
			speed_tracker += delta * text_speed
			if speed_tracker >= speed_threshold:
				text.visible_characters += 1
				speed_tracker = 0.0
		else:
			ready_to_advance = true
