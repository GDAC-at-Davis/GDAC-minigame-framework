extends Minigame

@export var controller : Node
@export var win_distance : float

func _ready():
	super._ready()
	controller.payload.defeated.connect(func() : lose())
	
func _process(delta: float) -> void:
	if controller.payload.global_position.distance_to(controller.player.global_position) > win_distance:
		win()
	
func win() -> void:
	$win.visible = true
	super.win()
	
func lose() -> void:
	$lose.visible = true
	super.lose()
