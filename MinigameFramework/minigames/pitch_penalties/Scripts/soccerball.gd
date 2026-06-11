extends CharacterBody2D

const SPEED:float = 75

var shot:bool = false

func _process(_delta) -> void:
	move_and_slide()
	if get_slide_collision_count() > 0:
		self.velocity = self.velocity.bounce(get_slide_collision(0).get_normal())
