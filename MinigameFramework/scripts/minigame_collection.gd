extends Control

## This scene will be used at the background for minigame transitions
@export var transition_background: PackedScene
## Total lives the player has for this group of minigames
@export var total_lives: int = 3
## Number of minigames needed to be played for the difficulty to increase
@export var difficulty_rate: int = 1
## Amount the difficulty increases each time
@export var difficulty_step: float = 0.1
## The difficulty to start at
@export var starting_difficulty: float = 1.0
## How long to stay on the transition screen
@export var transition_time: float = 2.0

var _minigame_scenes: Array[PackedScene]
var _minigame_data: MinigameGroupData

@onready var minigame_list: ItemList = $MinigameList
@onready var menu_button: Button = $MenuButton

func _ready():
	_minigame_data = MinigameGroupData.new()
	_minigame_data.transition_background = transition_background
	_minigame_data.total_minigames = 0
	_minigame_data.total_lives = total_lives
	_minigame_data.difficulty_rate = difficulty_rate
	_minigame_data.difficulty_step = difficulty_step
	_minigame_data.starting_difficulty = starting_difficulty
	_minigame_data.transition_time = transition_time
	
	minigame_list.item_selected.connect(_on_selection)
	menu_button.pressed.connect(_on_menu_button_pressed)
	
	for game: MinigameInfo in GameManager.minigame_collection:
		minigame_list.add_item(game.name, game.icon, true)
		_minigame_scenes.append(game.scene)

func _on_menu_button_pressed():
	GameManager.world_manager.load_ui("Menu")

func _on_selection(index: int):
	_minigame_data.minigames.clear()
	_minigame_data.minigames.append(_minigame_scenes[index])
	minigame_list.deselect_all()
	GameManager.switch_to_minigames(_minigame_data, true)
