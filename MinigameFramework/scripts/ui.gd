extends Control

@onready var text = $TextPanel/Text

func play_text(string : String):
	text.text = string
