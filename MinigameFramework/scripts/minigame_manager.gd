class_name MinigameManager
extends Control

signal minigame_completed

## How long to display instructions in seconds
const INSTRUCTION_DISPLAY_TIME: float = 1.0

var data: MinigameGroupData

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

var minigames_left: int = 0:
	set(new_value):
		minigames_left = new_value
		minigames_left_label.text = "Remaining\n" + str(minigames_left)
	get():
		return minigames_left

var current_minigame_node: Node
var current_minigame_component: MinigameComponent
var instruction_timer: Timer
var transition_timer: Timer

var _minigame_idx: int = 0:
	set(new_value):
		_minigame_idx = new_value
		if _minigame_idx >= data.minigames.size():
			_minigame_idx = 0
	get():
		return _minigame_idx

# Curve for controlling the instruction pop in
var _instruction_scale_curve: Curve = preload("res://resources/curves/instruction_scale_curve.tres")

@onready var minigame_ui_layer: CanvasLayer = $MinigameUILayer
@onready var minigame_layer: CanvasLayer = $MinigameLayer
@onready var transition_layer: CanvasLayer = $TransitionLayer
@onready var time_left_display: ProgressBar = $MinigameUILayer/TimeBar
@onready var instruction_label: RichTextLabel = $MinigameUILayer/InstructionLabel
@onready var health_bar: ProgressBar = $TransitionLayer/HealthBar
@onready var difficulty_label: RichTextLabel = $TransitionLayer/DifficultyLabel
@onready var minigames_left_label: RichTextLabel = $TransitionLayer/MinigamesLeftLabel
@onready var funny_little_guy: AnimationPlayer = $TransitionLayer/AnimatedSprite2D/AnimationPlayer

func _ready() -> void:
	minigame_completed.connect(_on_minigame_completed)
	funny_little_guy.play(&"spin") 
	
	instruction_timer = Timer.new()
	instruction_timer.one_shot = true
	instruction_timer.timeout.connect(_on_instruction_timer_timeout)
	add_child(instruction_timer)
	
	transition_timer = Timer.new()
	transition_timer.one_shot = true
	transition_timer.timeout.connect(_on_transition_timer_timeout)
	transition_timer.wait_time = data.transition_time
	add_child(transition_timer)
	transition_timer.start()
	
	health_bar.max_value = data.total_lives
	health_bar.value = data.total_lives
	lives_left = data.total_lives
	minigames_left = data.total_minigames
	
	minigame_ui_layer.visible = false
	
	data.minigames.shuffle()


func _process(delta):
	var weight = _instruction_scale_curve.sample_baked((INSTRUCTION_DISPLAY_TIME - instruction_timer.time_left) / (INSTRUCTION_DISPLAY_TIME))
	instruction_label.scale = Vector2(lerpf(1.0, 5.0, weight), lerpf(1.0, 5.0, weight))


func setup_data(minigame_data: MinigameGroupData):
	data = minigame_data


func start_minigame() -> void:
	if data.minigames.size() == 0:
		(get_parent() as GodScene).load_scene("Home")
		return
	var minigame_scene: PackedScene
	if minigames_left == 1 and data.final_minigame:
		minigame_scene = data.final_minigame
	else:
		minigame_scene = data.minigames[_minigame_idx]
	_minigame_idx += 1
	current_minigame_node = minigame_scene.instantiate()
	for child in current_minigame_node.get_children():
		if child is MinigameComponent:
			current_minigame_component = child
	current_minigame_component.minigame_manager = self
	minigame_layer.add_child(current_minigame_node)
	
	transition_layer.visible = false
	minigame_ui_layer.visible = true
	instruction_label.visible = true
	instruction_timer.start(INSTRUCTION_DISPLAY_TIME)
	instruction_label.text = current_minigame_component.instruction


func stop_minigame() -> void:
	current_minigame_node.queue_free()
	current_minigame_node = null
	current_minigame_component = null
	minigames_left -= 1
	if (data.total_minigames - minigames_left) % data.difficulty_rate == 0:
		difficulty_scale += data.difficulty_step
	minigame_ui_layer.visible = false
	transition_layer.visible = true
	if minigames_left == 0 or lives_left == 0:
		(get_parent() as GodScene).load_scene("Home")
	else:
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
	start_minigame()
