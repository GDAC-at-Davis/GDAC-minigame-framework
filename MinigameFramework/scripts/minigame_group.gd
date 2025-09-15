class_name MinigameGroupData
extends Resource

## Array of minigame scenes that the manager can choose from
@export var minigames: Array[PackedScene]
## This will replace the last minigame (boss fight)
@export var final_minigame: PackedScene
## This scene will be used at the background for minigame transitions
@export var transition_background: PackedScene
## Total minigames to be played
@export var total_minigames: int = 5
## Total lives the player has for this group of minigames
@export var total_lives: int = 3
## Number of minigames needed to be played for the difficulty to increase
@export var difficulty_rate: int = 2
## Amount the difficulty increases each time
@export var difficulty_step: float = 0.2
## How long to stay on the transition screen
@export var transition_time: float = 3.0
