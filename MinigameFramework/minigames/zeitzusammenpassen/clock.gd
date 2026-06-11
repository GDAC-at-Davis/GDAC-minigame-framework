"""
Creates an analog 12-hr clock that can display any valid time.
The clock can also be specified to be correct or not from
the perspective of some program.
"""
extends Area2D


@onready var _minute_hand: Node2D = $MinuteHand
@onready var _hour_hand: Node2D = $HourHand

var _mouse_entered: bool = false
var time: Vector2 # stored as Vector2(hours, minutes)
var correct: bool # is this the correct clock?

# rotates clock hands
func _rotate_clock_hands():
	var hour_rotation: float = RotationCalculator.rotate_hour_hand(time)
	var minute_rotation: float = RotationCalculator.rotate_minute_hand(time)
	
	_hour_hand.rotation = hour_rotation
	_minute_hand.rotation = minute_rotation


func _mouse_enter():
	_mouse_entered = true


func _mouse_exit():
	_mouse_entered = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("primary") and _mouse_entered:
			get_parent().clock_selected(correct)


func set_time(time: Vector2) -> bool:
	# if provided time is not in the range of [0, 12] for hours, [0, 60] for minutes, do nothing
	if time.x < 0 or time.x > 12 or time.y < 0 or time.y > 60:
		return false # error value
	
	# hour should have a discrete valueset: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
	# do nothing if hour is not in the above valueset
	if abs(floor(time.x) - time.x) > 0.01:
		return false # error value
	
	self.time = time
	_rotate_clock_hands()
	
	return true


func set_correct(correct: bool) -> void:
	self.correct = correct
