extends Minigame

@export var target_survival_time: float = 5.0
@export var left_bound: float = 80.0
@export var right_bound: float = 1200.0
@export var spawn_y: float = -40.0

@onready var player: AvalanchePlayer = $Player
@onready var spawner: HazardSpawner = $HazardSpawner
@onready var hazards: Node2D = $Hazards

var elapsed_time: float = 0.0

func start():
	randomize()
	target_survival_time = countdown_time
	elapsed_time = 0.0
	has_won = false
	has_ended = false
	player.bounds_left = left_bound
	player.bounds_right = right_bound
	player.reset_motion()
	spawner.reset(hazards, Vector2(left_bound, right_bound), spawn_y)
	spawner.difficulty_scale = difficulty
	spawner.active = true


func run():
	if has_ended:
		return
	var delta: float = get_physics_process_delta_time()
	elapsed_time += delta
	spawner.update_difficulty(delta, elapsed_time)
	if elapsed_time >= target_survival_time:
		win()


func hazard_hit_player() -> void:
	if has_ended:
		return
	lose()


func hazard_cleared() -> void:
	pass


func end():
	spawner.active = false
	player.disable_input()
	for child in hazards.get_children():
		if child.has_method("freeze_motion"):
			child.freeze_motion()
