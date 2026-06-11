class_name SnakeMinigameBody
extends CharacterBody2D


@export var previous_segment: CharacterBody2D


@export var distance = 100

@onready var sprite = $Icon

func _physics_process(delta: float) -> void:
	if global_position.distance_to(previous_segment.global_position) > distance:
		global_position = global_position.lerp(
			previous_segment.global_position + 
			previous_segment.global_position.direction_to(global_position) * distance,
			0.7
			)
				
	rotation = lerp_angle(rotation, (previous_segment.global_position - global_position).angle(), delta * 10.0)
