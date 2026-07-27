class_name Controller
extends Node

@export var movement_speed: float = 50.0

var possessed: Character
var enabled: bool = true: 
	set(new_value):
		enabled = new_value
		if not enabled and possessed:
			possessed.stop()
	get():
		return enabled
var _prev_direction: Vector2 
var _interaction_length: float = 20.0

func _physics_process(delta):
	if not enabled:
		return
	if possessed:
		var move_direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
		possessed.move(move_direction, movement_speed)
		if not move_direction == Vector2.ZERO:
			_prev_direction = move_direction
		if _prev_direction.y > 0.0:
			possessed.play_animation(&"FrontWalk")
		elif _prev_direction.y < 0.0:
			possessed.play_animation(&"BackWalk")
		elif _prev_direction.x < 0.0:
			possessed.set_sprite_flipped(true)
			possessed.play_animation(&"RightWalk")
		elif _prev_direction.x > 0.0:
			possessed.set_sprite_flipped(false)
			possessed.play_animation(&"RightWalk")

		var space_state: PhysicsDirectSpaceState2D = possessed.get_world_2d().direct_space_state
		var query: PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.create(possessed.global_position - (0.5 * _interaction_length * _prev_direction), possessed.global_position + (_interaction_length * _prev_direction))
		query.collide_with_areas = true
		query.collide_with_bodies = false
		var result: Dictionary = space_state.intersect_ray(query)
		if result:
			if result.collider is Interactable:
				result.collider.set_highlight(true)
				if Input.is_action_just_pressed("primary"):
					result.collider.interact(possessed)
