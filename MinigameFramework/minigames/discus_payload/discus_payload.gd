extends Minigame

@export var controller : Node
@export var win_distance : float

@export var num_spike_per_gap : Curve
@export var num_graps : Curve

func _ready():
	super._ready()
	controller.payload.defeated.connect(func() : lose())

	print(difficulty, " ", num_graps.sample(difficulty), " ", num_spike_per_gap.sample(difficulty))
	$Spikes.generate_spikes(num_graps.sample(difficulty), num_spike_per_gap.sample(difficulty))
	
func _process(delta: float) -> void:
	if controller.payload.global_position.distance_to(controller.player.global_position) > win_distance:
		win()
	
func win() -> void:
	$win.visible = true
	super.win()
	
func lose() -> void:
	$lose.visible = true
	super.lose()
