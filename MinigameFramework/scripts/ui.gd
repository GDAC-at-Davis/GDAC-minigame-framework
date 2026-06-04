class_name DialogueBox
extends Control

signal dialogue_completed

@onready var scene = get_parent()
@onready var text = $TextPanel/Text
@onready var panel = $TextPanel

var single_character_delay : float = 0.05
var lines : Array[String]

var _line_idx : int = 0
var _character_timer: Timer

func _ready():
	_character_timer = Timer.new()
	_character_timer.one_shot = false
	_character_timer.autostart = false
	_character_timer.timeout.connect(_on_character_timer_timeout)
	add_child(_character_timer)

func play_text(playtext : Array):
	var overworld: Overworld = GameManager.current_scene as Overworld
	overworld.controller.enabled = false
	panel.visible = true
	lines = playtext
	_line_idx = 0
	play_text_index()
	process_mode = Node.PROCESS_MODE_ALWAYS

func close():
	var overworld: Overworld = GameManager.current_scene as Overworld
	overworld.controller.enabled = true
	panel.visible = false
	_character_timer.stop()
	process_mode = Node.PROCESS_MODE_DISABLED
	dialogue_completed.emit()

func play_text_index():
	if _line_idx >= lines.size():
		close()
		return
	text.text = lines[_line_idx]
	text.visible_characters = 0
	_character_timer.start(single_character_delay)
	_line_idx += 1

func _process(delta):
	if Input.is_action_just_pressed("primary") or Input.is_action_pressed("secondary"):
		if text.visible_characters < text.text.length():
			text.visible_characters = text.text.length()
		else:
			play_text_index()

func _on_character_timer_timeout():
	if text.visible_characters < text.text.length():
		text.visible_characters += 1
	else:
		_character_timer.stop()
