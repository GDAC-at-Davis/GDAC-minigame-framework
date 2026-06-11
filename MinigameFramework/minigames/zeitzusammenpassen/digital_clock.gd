"""
Displays the target time in a digital format
"""
extends Node


@onready var label:Label = $Label


func set_time(time: Vector2) -> void:
	var hours = str(int(time.x)).pad_zeros(2)
	var minutes = str(int(time.y)).pad_zeros(2)
	
	label.text = "%s:%s" % [hours, minutes]
