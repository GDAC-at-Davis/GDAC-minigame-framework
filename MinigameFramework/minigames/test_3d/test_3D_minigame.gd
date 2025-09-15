extends Minigame

@onready var cube: MeshInstance3D = $MeshInstance3D

func run():
	if Input.is_action_just_pressed("primary"):
		win()
	if has_won:
		cube.rotation.y += PI/12
