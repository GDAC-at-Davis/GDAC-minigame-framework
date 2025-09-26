class_name MinigameManager
extends Control

signal minigame_completed

## How long to display instructions in seconds
const INSTRUCTION_DISPLAY_TIME: float = 1.0
## How long to fade the minigame in/out in seconds
const FADE_TIME: float = 0.2

var data: MinigameGroupData

var playing: bool = false

var lives_left: int = 0:
	set(new_value):
		lives_left = new_value
		health_bar.value = lives_left
	get():
		return lives_left

var difficulty_scale: float = 1.0:
	set(new_value):
		difficulty_scale = new_value
		difficulty_label.text = "Difficulty\n" + str(snappedf(difficulty_scale * 100, 1.0)) + "%"
	get():
		return difficulty_scale

var minigames_completed: int = 0:
	set(new_value):
		minigames_completed = new_value
		if _endless:
			minigames_left_label.text = "Completed\n" + str(minigames_completed)
		else:
			minigames_left_label.text = "Remaining\n" + str(data.total_minigames - minigames_completed)
	get():
		return minigames_completed

var current_minigame_node: Minigame
var instruction_timer: Timer
var transition_timer: Timer
var fade_timer: Timer

var _minigame_idx: int = 0:
	set(new_value):
		_minigame_idx = new_value
		if _minigame_idx >= data.minigames.size():
			_minigame_idx = 0
	get():
		return _minigame_idx

var _endless: bool = false

# Curve for controlling the instruction pop in
var _instruction_scale_curve: Curve = preload("res://resources/curves/instruction_scale_curve.tres")
var _fade_curve: Curve = preload("res://resources/curves/fade_curve.tres")

@onready var minigame_ui_layer: CanvasLayer = $MinigameUILayer
@onready var minigame_layer: CanvasLayer = $MinigameLayer
@onready var transition_layer: CanvasLayer = $TransitionLayer
@onready var time_left_display: ProgressBar = $MinigameUILayer/TimeBar
@onready var instruction_label: RichTextLabel = $MinigameUILayer/InstructionLabel
@onready var health_bar: ProgressBar = $TransitionLayer/HealthBar
@onready var difficulty_label: RichTextLabel = $TransitionLayer/DifficultyLabel
@onready var minigames_left_label: RichTextLabel = $TransitionLayer/MinigamesLeftLabel
@onready var transition_modulate: CanvasModulate = $TransitionLayer/CanvasModulate

func _ready():
	instruction_timer = Timer.new()
	instruction_timer.one_shot = true
	instruction_timer.timeout.connect(_on_instruction_timer_timeout)
	add_child(instruction_timer)
	
	transition_timer = Timer.new()
	transition_timer.one_shot = true
	transition_timer.timeout.connect(_on_transition_timer_timeout)
	add_child(transition_timer)
	
	fade_timer = Timer.new()
	fade_timer.one_shot = true
	fade_timer.timeout.connect(_on_fade_timer_timeout)
	add_child(fade_timer)

func _process(_delta):
	if instruction_timer.time_left > 0:
		var weight = _instruction_scale_curve.sample_baked((INSTRUCTION_DISPLAY_TIME - instruction_timer.time_left) / (INSTRUCTION_DISPLAY_TIME))
		instruction_label.scale = Vector2(lerpf(1.0, 5.0, weight), lerpf(1.0, 5.0, weight))
	if fade_timer.time_left > 0:
		var weight: float
		if playing:
			weight = _fade_curve.sample_baked((fade_timer.time_left) / (FADE_TIME))
		else:
			weight = _fade_curve.sample_baked((FADE_TIME - fade_timer.time_left) / (FADE_TIME))
		transition_modulate.color.a = weight

func start(minigame_data: MinigameGroupData, endless: bool = false):
	data = minigame_data
	minigame_completed.connect(_on_minigame_completed)
	
	current_minigame_node = null
	_endless = endless
	transition_timer.wait_time = data.transition_time
	health_bar.max_value = data.total_lives
	health_bar.value = data.total_lives
	lives_left = data.total_lives
	minigames_completed = 0
	difficulty_scale = data.starting_difficulty
	_minigame_idx = 0
	
	if data.transition_background:
		transition_layer.add_child(data.transition_background.instantiate())
	minigame_ui_layer.visible = false
	
	data.minigames.shuffle()
	transition_timer.start()

func start_minigame() -> void:
	if data.minigames.size() == 0:
		GameManager.switch_to_world()
		return
	playing = true
	var minigame_scene: PackedScene
	if minigames_completed == data.total_minigames - 1 and data.final_minigame:
		minigame_scene = data.final_minigame
	else:
		minigame_scene = data.minigames[_minigame_idx]
	_minigame_idx += 1
	current_minigame_node = minigame_scene.instantiate()
	minigame_layer.add_child(current_minigame_node)
	
	minigame_ui_layer.visible = true
	instruction_label.visible = true
	instruction_timer.start(INSTRUCTION_DISPLAY_TIME)
	instruction_label.text = current_minigame_node.instruction
	fade_timer.start(FADE_TIME)

func stop_minigame() -> void:
	playing = false
	if lives_left > 0:
		minigames_completed += 1
		if minigames_completed % data.difficulty_rate == 0:
			difficulty_scale += data.difficulty_step
	fade_timer.start(FADE_TIME)
	transition_layer.visible = true
	transition_timer.start()
		


func update_time_display(current_time: float, max_time: float) -> void:
	time_left_display.max_value = max_time
	time_left_display.value = snappedf(current_time, 1.0)



func _on_minigame_completed(has_won: bool):
	if not has_won:
		lives_left -= 1
	stop_minigame()


func _on_instruction_timer_timeout():
	instruction_label.visible = false


func _on_transition_timer_timeout():
	if (not _endless and minigames_completed == data.total_minigames) or lives_left == 0:
		GameManager.switch_to_world()
	else:
		start_minigame()

func _on_fade_timer_timeout():
	if playing:
		transition_layer.visible = false
	else:
		current_minigame_node.queue_free()
		current_minigame_node = null
		minigame_layer.visible = false
		
