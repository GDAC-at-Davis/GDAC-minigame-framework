"""
Displays the result of the minigame, that is, whether the selction was correct or not
"""
extends Node


@onready var label:Label = $Label

# sets the label text to the specified string
func set_text(text: String) -> void:	
	label.text = text

# sets the label font color to the specified color
func set_color(color: Color) -> void:	
	label.label_settings.font_color = color
