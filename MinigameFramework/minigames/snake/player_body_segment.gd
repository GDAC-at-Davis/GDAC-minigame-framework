class_name SnakeMinigameBody
extends CharacterBody2D


@export var previous_segment: CharacterBody2D


@export var distance = 100


func _physics_process(delta: float) -> void:
	if global_position.distance_to(previous_segment.global_position) > distance:
		global_position = (previous_segment.global_position + 
				previous_segment.global_position.direction_to(global_position) * distance)
