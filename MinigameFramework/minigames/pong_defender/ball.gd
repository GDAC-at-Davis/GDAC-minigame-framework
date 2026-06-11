class_name Ball
extends Node2D

@onready
var character : Node2D = get_child(0)

func set_vel(x, y):
	character.set_vel(x,y)
