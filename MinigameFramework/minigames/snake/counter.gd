@tool
extends Node2D

const COUNTER_DIGIT = preload("uid://dpwjerilx72yn")

@export
var value: int:
	get():
		return value
	set(v):
		value = v
		if is_node_ready():
			_update()
		return value

@onready var digit_holder: Node2D = $DigitHolder

func _ready():
	_update()

func _update():
	var digits_used: int = 1
	var digits := digit_holder.get_children()
	var rest: int = value
	
	var ones = digits.pop_back()
	ones.value = rest % 10
	ones.visible = true
	rest /= 10
	
	while rest and len(digits):
		digits_used += 1
		var digit = digits.pop_back()
		digit.value = rest % 10
		digit.visible = true
		rest /= 10
	
	for digit in digits:
		digit.visible = false
	
	digit_holder.position.x = 4 * (digits_used - 1)
