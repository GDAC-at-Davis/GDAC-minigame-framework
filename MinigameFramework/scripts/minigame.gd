class_name Minigame
extends Node

@export_category("Information")
## Instruction that displays at the start of the minigame
@export var instruction: String = "Do something!"

@export_category("Timers")
## Time in seconds until the minigame ends. Will call lose() if the player hasn't won by the time this ends. Set this to 0 or any negative value to disable.
@export var countdown_time: float = 5.0
## Time in seconds to skip the countdown timer to when the minigame ends
@export var skip_time: float = 1.0

var countdown_timer: Timer

## Represents the current difficulty level of the minigame. A value of 2.0 should roughly translate to the minigame being twice as difficult.
var difficulty: float = 1.0
## True if the player has won the minigame.
var has_won: bool = false
## True after win() or lose() is called.
var has_ended: bool = false


func _ready():
	countdown_timer = Timer.new()
	add_child(countdown_timer)
	countdown_timer.timeout.connect(_on_countdown_timeout)
	
	difficulty = GameManager.minigame_manager.difficulty_scale
	
	start()
	
	countdown_timer.wait_time = countdown_time
	if countdown_time > 0.0:
		countdown_timer.start()


func _physics_process(_delta):
	GameManager.minigame_manager.update_time_display(countdown_timer.time_left, countdown_time)
	run()


## This is called once at the start of the minigame.
func start() -> void:
	pass


## This is called 60 times per second.
func run() -> void:
	pass


## This is called after win() or lose() is called.
func end() -> void:
	pass

## This is called when the countdown timer finishes.
func complete() -> void:
	pass


## Call this whenever a win condition is met. Make sure to call super() if this is overridden.
func win() -> void:
	if has_ended:
		return
	has_won = true
	_handle_end()


## Call this whenever a lose condition is met. Make sure to call super() if this is overridden. This is automatically called when the countdown timer finishes.
func lose() -> void:
	if has_ended:
		return
	has_won = false
	_handle_end()


func _handle_end():
	has_ended = true
	if countdown_timer.time_left > skip_time:
		countdown_timer.start(skip_time)
	end()


func _on_countdown_timeout():
	if not has_won:
		lose()
	complete()
	GameManager.minigame_manager.minigame_completed.emit(has_won)
